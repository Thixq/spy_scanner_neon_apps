// ble_manager_test.dart

import 'dart:async';

import 'package:flutter_reactive_ble/flutter_reactive_ble.dart' hide Logger;
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:spy_scanner/core/logging/custom_logger.dart';
import 'package:spy_scanner/core/logging/error_handler.dart';
import 'package:spy_scanner/feature/managers/ble_manager.dart';

// Test edilecek sınıfların ve bağımlılıkların gerçek import yolları

// Mock sınıflarının oluşturulacağı dosya (generate edildikten sonra)
import 'ble_manager_test.mocks.dart';

// Mock sınıflarını oluşturmak için anotasyonlar
@GenerateMocks([
  FlutterReactiveBle,
  CustomLogger,
  ErrorHandler,
  StreamSubscription,
  DiscoveredDevice,
  Logger,
])
void main() {
  // Mock nesneler
  late MockFlutterReactiveBle mockBle;
  late StreamController<BleStatus> statusStreamController;

  // Test edilecek sınıf (BleManager)
  late BleManager bleManager;

  // Mock DiscoveredDevice nesneleri için yardımcı metot
  MockDiscoveredDevice createMockDevice(String id, String name) {
    final device = MockDiscoveredDevice();
    when(device.id).thenReturn(id);
    when(device.name).thenReturn(name);
    return device;
  }

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
      // ... Diğer kritik alanları buraya ekleyin
    ]);
  }

  // Her testten önce çalışacak kurulum
  setUp(() {
    // 1. Mock nesneleri ve StreamController'ları oluştur
    statusStreamController = StreamController<BleStatus>.broadcast();
    mockBle = MockFlutterReactiveBle();

    // 2. `FlutterReactiveBle` Mock Davranışlarını Ayarla
    when(mockBle.statusStream).thenAnswer((_) => statusStreamController.stream);

    // 3. BleManager'ı mock'lanmış bağımlılık ile oluştur
    bleManager = BleManager(ble: mockBle);

    // DİKKAT: İlk status yayını buradan KALDIRILDI. Testler, gerektiğinde status yayınlayacak.
  });

  // Her testten sonra çalışacak temizlik
  tearDown(() async {
    bleManager.dispose();
    await statusStreamController.close();
    reset(mockBle);
  });

  // -------------------------------------------------------------------

  group('BleManager Initialization and Status Management', () {
    test('Should start listening to statusStream and update status', () async {
      // Assert: expectLater dinlemeye başlar
      expectLater(
        bleManager.statusStream,
        emitsInOrder([
          BleStatus.ready,
          BleStatus.poweredOff,
        ]),
      );

      // Act: Durumları sırayla yayınla
      statusStreamController
        ..add(BleStatus.ready)
        ..add(BleStatus.poweredOff);
    });

    test(
      'Should stop scan when status changes to not ready (e.g., poweredOff)',
      () async {
        // Arrange
        final scanStreamController =
            StreamController<DiscoveredDevice>.broadcast();

        // Mock ayarı
        when(
          mockBle.scanForDevices(
            withServices: anyNamed('withServices'),
            scanMode: anyNamed('scanMode'),
          ),
        ).thenAnswer((_) => scanStreamController.stream);

        // 1. isScanningStream beklentisini oluştur ve dinlemeyi başlat.
        final isScanningExpectation = expectLater(
          bleManager.isScanningStream,
          emitsInOrder([
            true, // startScan() çağrıldığında beklenir
            false, // statusController.add(poweredOff) çağrıldığında beklenir
          ]),
        );

        // Act 1: BLE'yi hazır hale getir (Bu, startScan'in çalışması için zorunludur)
        statusStreamController.add(BleStatus.ready);
        // BleManager'ın iç dinleyicisinin bu status'ü almasını bekle
        await Future<void>.delayed(Duration.zero);

        // Act 2: Taramayı başlat (Bu, 'true' olayını tetikler)
        await bleManager.startScan();

        // Act 3: Durumu hazır olmayan bir duruma değiştir (Bu, 'false' olayını tetikler)
        statusStreamController.add(BleStatus.poweredOff);
        await Future<void>.delayed(Duration.zero);

        // Assert: Testin tüm beklentilerinin tamamlandığından emin ol.
        await isScanningExpectation;
        await scanStreamController.close();
      },
    );

    // Yeni Test: Bluetooth hazır değilken tarama başlatılmamalı
    test(
      'Should not start scan if initial status is not ready (e.g., poweredOff)',
      () async {
        // Arrange
        statusStreamController.add(BleStatus.poweredOff);
        await Future<void>.delayed(Duration.zero);

        // Act
        await bleManager
            .startScan(); // Bu, status'ün hazır olmaması nedeniyle await stopScan()'i çağıracak.

        // Assert 1: scanForDevices asla çağrılmamalı (kontrolün başarılı olduğunu doğrular)
        verifyNever(
          mockBle.scanForDevices(
            withServices: anyNamed('withServices'),
            scanMode: anyNamed('scanMode'),
          ),
        );

        // Assert 2: stopScan() çağrıldığından, stream'den false değeri gelmelidir.
        // İlk false değeri constructor'dan geldiği için, burada bir sonraki false değerini bekliyoruz.
        final emitsFalseExpectation = expectLater(
          bleManager.isScanningStream,
          neverEmits(true),
        );
        bleManager.dispose();
        // Assert 4: False yayınlandığını bekle
        await emitsFalseExpectation;
      },
    );
  });

  // -------------------------------------------------------------------

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

      // Tarama testleri için başlangıç durumu hazır olmalı
      statusStreamController.add(BleStatus.ready);
      // BleManager'ın status'ü alması için bekle
      return Future<void>.delayed(Duration.zero);
    });

    tearDown(() async {
      await scanStreamController.close();
    });

    test(
      'startScan should initiate scan and update isScanningStream',
      () async {
        // Arrange
        final isScanningExpectation = expectLater(
          bleManager.isScanningStream,
          emits(true),
        );

        // Act
        await bleManager.startScan();

        // Assert
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
      // Arrange
      // İlk taramayı başlat ve isScanning=true olmasını bekle
      await bleManager.startScan();

      // Act
      await bleManager.startScan(); // İkinci kez başlatmayı dene

      // Assert
      // `scanForDevices` sadece bir kez çağrılmalı (ilk çağrıda)
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
        // Arrange
        final devicesList = <List<DiscoveredDevice>>[];

        // İlk boş listeyi beklemek için ilk dinleyiciyi başlat
        final scannedDevicesExpectation = expectLater(
          bleManager.scannedDevicesStream,
          emitsInOrder([
            isEmpty,
            // Listeyi mock nesneleri yerine Matcher'larla doldur.
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

        // Listeyi toplamak için ayrı bir dinleyici (opsiyonel ama daha iyi görünürlük sağlar)
        bleManager.scannedDevicesStream.listen(devicesList.add);

        // Act 1: Taramayı başlat (Bu, boş listeyi yayınlar)
        await bleManager.startScan();
        await Future<void>.delayed(Duration.zero);

        // Act 2: Cihazlar yayınla
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

        // Assert
        await scannedDevicesExpectation;

        // Manuel kontrol (doğrulama için)
        expect(devicesList.length, 4);
        final finalDevice1 = devicesList.last.firstWhere(
          (d) => d.id == 'dev-01',
        );
        expect(finalDevice1.name, 'TestDevice1_Updated');
      },
    );

    test('stopScan should set isScanning to false', () async {
      // Arrange
      await bleManager.startScan();

      final isScanningExpectation = expectLater(
        bleManager.isScanningStream,
        emits(
          false,
        ), // Sadece false yayınlanmasını bekliyoruz. true zaten yayınlandı.
      );

      // Act: Durdur
      await bleManager.stopScan();

      // Assert
      await isScanningExpectation;
    });

    test('Scan stream onError should trigger stopScan', () async {
      // Arrange
      await bleManager.startScan();

      final isScanningExpectation = expectLater(
        bleManager.isScanningStream,
        emits(
          false,
        ), // Hata sonrası durdurma ile false yayınlanmasını bekliyoruz
      );

      // Act: Stream'e bir hata gönder
      scanStreamController.addError(Exception('BLE Stream Error'));
      await Future<void>.delayed(Duration.zero);

      // Assert
      await isScanningExpectation;
      // `stopScan` çağrıldığı için tarama bayrağı false olmalıdır.
    });
  });

  // -------------------------------------------------------------------

  group('Dispose', () {
    test('dispose should close all internal stream controllers', () async {
      // Arrange
      final isScanningClosed = bleManager.isScanningStream.isEmpty;
      final scannedDevicesClosed = bleManager.scannedDevicesStream.isEmpty;

      // Act
      bleManager.dispose();

      // Assert
      expect(
        isScanningClosed,
        completes,
        reason: 'isScanningController kapatılmalı',
      );
      expect(
        scannedDevicesClosed,
        completes,
        reason: 'scannedDevicesController kapatılmalı',
      );
    });
  });
}
