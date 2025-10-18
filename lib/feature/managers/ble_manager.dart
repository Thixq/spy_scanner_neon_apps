// ignore_for_file: discarded_futures, document_ignores

import 'dart:async';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:spy_scanner/core/logging/custom_logger.dart';
import 'package:spy_scanner/core/logging/error_handler.dart';
import 'package:spy_scanner/feature/models/bluetooth_device_model.dart';

/// A manager class to handle BLE operations such as scanning and monitoring Bluetooth status.
/// This class encapsulates the functionality of the `flutter_reactive_ble` package,
/// providing a cleaner interface for starting/stopping scans and listening to status changes.
final class BleManager {
  BleManager({required FlutterReactiveBle ble}) : _ble = ble {
    _isScanning = false;
    _isScanningController.add(_isScanning);

    _statusSubscription = _ble.statusStream.listen((status) {
      _logger.info('Bluetooth status changed: $status');
      _currentStatus = status;

      if (status != BleStatus.ready) {
        _logger.warning('Bluetooth is not ready. Stopping scan if active.');
        stopScan();
      }
    });
    _logger.info('BleManager initialized and listening to BLE status.');
  }

  final _logger = CustomLogger('BleManager');
  final _errorHandler = ErrorHandler('BleManager');

  final FlutterReactiveBle _ble;

  final _scannedDevicesController =
      StreamController<List<BluetoothDeviceModel>>.broadcast();
  final _isScanningController = StreamController<bool>.broadcast();

  StreamSubscription<DiscoveredDevice>? _scanSubscription;
  StreamSubscription<BleStatus>? _statusSubscription;

  final List<BluetoothDeviceModel> _internalDeviceList = [];
  late BleStatus _currentStatus = BleStatus.unknown;
  bool _isScanning = false;

  Stream<BleStatus> get statusStream => _ble.statusStream;
  Stream<List<BluetoothDeviceModel>> get scannedDevicesStream =>
      _scannedDevicesController.stream;
  Stream<bool> get isScanningStream => _isScanningController.stream;

  /// Starts a scan for BLE devices.
  Future<void> startScan() async {
    if (_isScanning) {
      _logger.info('Scan is already in progress. Ignoring request.');
      return;
    }
    if (_currentStatus != BleStatus.ready) {
      _logger.warning(
        'Cannot start scan: Bluetooth is not ready (Status: $_currentStatus).',
      );
      await stopScan();
      return;
    }

    _logger.info('Starting BLE scan...');
    _internalDeviceList.clear();
    _scannedDevicesController.add([]);

    _isScanning = true;
    _isScanningController.add(true);

    await _errorHandler.executeSafely(
      () async {
        _scanSubscription = _ble
            .scanForDevices(
              withServices: [],
              scanMode: ScanMode.lowLatency,
            )
            .listen(
              (device) {
                final knownDeviceIndex = _internalDeviceList.indexWhere(
                  (d) => d.id == device.id,
                );
                if (knownDeviceIndex >= 0) {
                  _internalDeviceList[knownDeviceIndex] = BluetoothDeviceModel(
                    id: device.id,
                    name: device.name,
                    rssi: device.rssi,
                  );
                } else {
                  _internalDeviceList.add(
                    BluetoothDeviceModel(
                      id: device.id,
                      name: device.name,
                      rssi: device.rssi,
                    ),
                  );
                }
                _scannedDevicesController.add(
                  List.unmodifiable(_internalDeviceList),
                );
              },
              onError: (Object error, StackTrace stackTrace) {
                // Bu onError, stream çalışırken oluşan hatalar içindir.
                _logger.error(
                  'Error on BLE scan stream',
                  error: error,
                  stackTrace: stackTrace,
                );
                stopScan();
              },
            );
      },
      errorMessage: 'Failed to initiate BLE scan',
      onError: (error, stackTrace) {
        _isScanning = false;
        _isScanningController.add(false);
      },
    );
  }

  /// Stops the currently active BLE device scan.
  Future<void> stopScan() async {
    if (!_isScanning) return;

    await _errorHandler.executeSafely(
      () async => await _scanSubscription?.cancel(),
      errorMessage: 'Error while cancelling scan subscription',
    );
    _scanSubscription = null;
    _isScanning = false;
    _isScanningController.add(false);
    _logger.info('BLE scan stopped.');
  }

  /// Releases all resources when the manager is no longer needed.
  void dispose() {
    _statusSubscription?.cancel();
    _scanSubscription?.cancel();
    _scannedDevicesController.close();
    _isScanningController.close();
    _logger.info('BleManager disposed.');
  }
}
