// ignore_for_file: discarded_futures, document_ignores

import 'dart:async';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:spy_scanner/core/logging/custom_logger.dart';
import 'package:spy_scanner/core/logging/error_handler.dart';
import 'package:spy_scanner/feature/models/bluetooth_device_model.dart';
// import 'bluetooth_status_monitor.dart'; // Bu sınıfı bu dosyaya import etmeniz gerekir

/// A manager class to handle BLE device scanning operations.
final class BleScannerManager {
  BleScannerManager({
    required FlutterReactiveBle ble,
  }) : _ble = ble {
    _isScanning = false;
    _isScanningController.add(_isScanning);
    _logger.info('BleScannerManager initialized.');
  }

  final _logger = CustomLogger('BleScannerManager');
  final _errorHandler = ErrorHandler('BleScannerManager');

  final FlutterReactiveBle _ble;

  final _scannedDevicesController =
      StreamController<List<BluetoothDeviceModel>>.broadcast();
  final _isScanningController = StreamController<bool>.broadcast();

  StreamSubscription<DiscoveredDevice>? _scanSubscription;

  final List<BluetoothDeviceModel> _internalDeviceList = [];
  bool _isScanning = false;

  /// Gets the stream of discovered BLE devices.
  Stream<List<BluetoothDeviceModel>> get scannedDevicesStream =>
      _scannedDevicesController.stream;

  /// Gets the stream indicating whether a scan is currently active.
  Stream<bool> get isScanningStream => _isScanningController.stream;

  /// Starts a scan for BLE devices.
  ///
  /// Note: The caller must ensure that the Bluetooth adapter is ready (BleStatus.ready).
  Future<void> startScan({
    BleStatus currentStatus = BleStatus.unknown,
  }) async {
    if (_isScanning) {
      _logger.info('Scan is already in progress. Ignoring request.');
      return;
    }

    // Harici durum kontrolü (Sınıf dışından bilgi alarak uyumluluk sağlar)
    if (currentStatus != BleStatus.ready) {
      _logger.warning(
        'Cannot start scan: Bluetooth is not ready (Status: $currentStatus).',
      );
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
                // Cihaz listesini güncelleme
                final knownDeviceIndex = _internalDeviceList.indexWhere(
                  (d) => d.id == device.id,
                );
                final newDevice = BluetoothDeviceModel(
                  id: device.id,
                  name: device.name,
                  rssi: device.rssi,
                );

                if (knownDeviceIndex >= 0) {
                  _internalDeviceList[knownDeviceIndex] = newDevice;
                } else {
                  _internalDeviceList.add(newDevice);
                }

                // Unmodifiable list'i yayınla
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
                // Stream hatasında taramayı durdur
                stopScan();
              },
            );
      },
      errorMessage: 'Failed to initiate BLE scan',
      onError: (error, stackTrace) {
        // startScan sırasında oluşan hata (örn. izin eksikliği)
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
    _scanSubscription?.cancel();
    _scannedDevicesController.close();
    _isScanningController.close();
    _logger.info('BleScannerManager disposed.');
  }
}
