import 'dart:async';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart' hide Logger;
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:spy_scanner/core/logging/custom_logger.dart';
import 'package:spy_scanner/core/logging/error_handler.dart';
import 'package:spy_scanner/feature/managers/ble_manager.dart';
import 'package:spy_scanner/feature/models/bluetooth_device_model.dart';

import 'ble_manager_test.mocks.dart';

@GenerateMocks([
  FlutterReactiveBle,
  CustomLogger,
  ErrorHandler,
  StreamSubscription,
  DiscoveredDevice,
  BluetoothDeviceModel,
  Logger,
])
void main() {
  late MockFlutterReactiveBle mockBle;
  late StreamController<BleStatus> statusStreamController;
  late BleManager bleManager;

  // Helper method for creating mock DiscoveredDevice objects
  MockDiscoveredDevice createMockDevice(String id, String name) {
    final device = MockDiscoveredDevice();
    when(device.id).thenReturn(id);
    when(device.name).thenReturn(name);
    return device;
  }

  // Matcher to compare DiscoveredDevice by ID and Name
  Matcher matchesDevice({required String id, required String name}) {
    return allOf([
      predicate<DiscoveredDevice>(
        (d) => d.id == id,
        'Device id should be $id',
      ),
      predicate<DiscoveredDevice>(
        (d) => d.name == name,
        'Device name should be $name',
      ),
    ]);
  }

  setUp(() {
    statusStreamController = StreamController<BleStatus>.broadcast();
    mockBle = MockFlutterReactiveBle();

    when(mockBle.statusStream).thenAnswer((_) => statusStreamController.stream);

    bleManager = BleManager(ble: mockBle);
  });

  tearDown(() async {
    bleManager.dispose();
    await statusStreamController.close();
    reset(mockBle);
  });

  group('BleManager Initialization and Status Management', () {
    test('Should start listening to statusStream and update status', () async {
      final statusStreamExpectation = expectLater(
        bleManager.statusStream,
        emitsInOrder([
          BleStatus.ready,
          BleStatus.poweredOff,
        ]),
      );

      statusStreamController
        ..add(BleStatus.ready)
        ..add(BleStatus.poweredOff);

      await statusStreamExpectation;
    });

    test(
      'Should stop scan when status changes to not ready (e.g., poweredOff)',
      () async {
        final scanStreamController =
            StreamController<DiscoveredDevice>.broadcast();

        when(
          mockBle.scanForDevices(
            withServices: anyNamed('withServices'),
            scanMode: anyNamed('scanMode'),
          ),
        ).thenAnswer((_) => scanStreamController.stream);

        final isScanningExpectation = expectLater(
          bleManager.isScanningStream,
          emitsInOrder([
            true,
            false,
          ]),
        );

        statusStreamController.add(BleStatus.ready);
        await Future<void>.delayed(Duration.zero);

        await bleManager.startScan();

        statusStreamController.add(BleStatus.poweredOff);
        await Future<void>.delayed(Duration.zero);

        await isScanningExpectation;
        await scanStreamController.close();
      },
    );

    test(
      'Should not start scan if initial status is not ready (e.g., poweredOff)',
      () async {
        statusStreamController.add(BleStatus.poweredOff);
        await Future<void>.delayed(Duration.zero);

        await bleManager.startScan();

        verifyNever(
          mockBle.scanForDevices(
            withServices: anyNamed('withServices'),
            scanMode: anyNamed('scanMode'),
          ),
        );

        final emitsFalseExpectation = expectLater(
          bleManager.isScanningStream,
          neverEmits(true),
        );
        bleManager.dispose();
        await emitsFalseExpectation;
      },
    );
  });

  group('Scan Operations', () {
    late StreamController<DiscoveredDevice> scanStreamController;

    setUp(() {
      scanStreamController = StreamController<DiscoveredDevice>.broadcast();
      when(
        mockBle.scanForDevices(
          withServices: anyNamed('withServices'),
          scanMode: anyNamed('scanMode'),
        ),
      ).thenAnswer((_) => scanStreamController.stream);

      statusStreamController.add(BleStatus.ready);
      return Future<void>.delayed(Duration.zero);
    });

    tearDown(() async {
      await scanStreamController.close();
    });

    test(
      'startScan should initiate scan and update isScanningStream',
      () async {
        final isScanningExpectation = expectLater(
          bleManager.isScanningStream,
          emits(true),
        );

        await bleManager.startScan();

        await isScanningExpectation;

        verify(
          mockBle.scanForDevices(
            withServices: const [],
            scanMode: ScanMode.lowLatency,
          ),
        ).called(1);
      },
    );

    test('startScan should not start if already scanning', () async {
      await bleManager.startScan();

      await bleManager.startScan();

      verify(
        mockBle.scanForDevices(
          withServices: anyNamed('withServices'),
          scanMode: anyNamed('scanMode'),
        ),
      ).called(1);
    });

    test(
      'Should update scannedDevicesStream with new and updated discovered devices',
      () async {
        final devicesList = <List<BluetoothDeviceModel>>[];

        final scannedDevicesExpectation = expectLater(
          bleManager.scannedDevicesStream,
          emitsInOrder([
            isEmpty,
            [matchesDevice(id: 'dev-01', name: 'TestDevice1')],
            [
              matchesDevice(id: 'dev-01', name: 'TestDevice1'),
              matchesDevice(id: 'dev-02', name: 'TestDevice2'),
            ],
            [
              matchesDevice(id: 'dev-01', name: 'TestDevice1_Updated'),
              matchesDevice(id: 'dev-02', name: 'TestDevice2'),
            ],
          ]),
        );

        bleManager.scannedDevicesStream.listen(devicesList.add);

        await bleManager.startScan();
        await Future<void>.delayed(Duration.zero);

        scanStreamController.add(createMockDevice('dev-01', 'TestDevice1'));
        await Future<void>.delayed(Duration.zero);

        scanStreamController.add(createMockDevice('dev-02', 'TestDevice2'));
        await Future<void>.delayed(Duration.zero);

        final updatedDevice1 = createMockDevice(
          'dev-01',
          'TestDevice1_Updated',
        );
        scanStreamController.add(updatedDevice1);
        await Future<void>.delayed(Duration.zero);

        await scannedDevicesExpectation;

        expect(devicesList.length, 4);
        final finalDevice1 = devicesList.last.firstWhere(
          (d) => d.id == 'dev-01',
        );
        expect(finalDevice1.name, 'TestDevice1_Updated');
      },
    );

    test('stopScan should set isScanning to false', () async {
      await bleManager.startScan();

      final isScanningExpectation = expectLater(
        bleManager.isScanningStream,
        emits(false),
      );

      await bleManager.stopScan();

      await isScanningExpectation;
    });

    test('Scan stream onError should trigger stopScan', () async {
      await bleManager.startScan();

      final isScanningExpectation = expectLater(
        bleManager.isScanningStream,
        emits(false),
      );

      scanStreamController.addError(Exception('BLE Stream Error'));
      await Future<void>.delayed(Duration.zero);

      await isScanningExpectation;
    });
  });

  group('Dispose', () {
    test('dispose should close all internal stream controllers', () async {
      final isScanningClosed = bleManager.isScanningStream.isEmpty;
      final scannedDevicesClosed = bleManager.scannedDevicesStream.isEmpty;

      bleManager.dispose();

      expect(
        isScanningClosed,
        completes,
        reason: 'isScanningController should be closed',
      );
      expect(
        scannedDevicesClosed,
        completes,
        reason: 'scannedDevicesController should be closed',
      );
    });
  });
}
