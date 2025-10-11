// ignore_for_file: discarded_futures, document_ignores

import 'dart:async';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

/// A manager class to handle BLE operations such as scanning and monitoring Bluetooth status.
/// This class encapsulates the functionality of the `flutter_reactive_ble` package,
/// providing a cleaner interface for starting/stopping scans and listening to status changes.
final class BleManager {
  BleManager() {
    // Initially, report that scanning is off to both the variable and the stream.
    _isScanning = false;
    _isScanningController.add(_isScanning);

    // Start listening to the Bluetooth status and store the current state.
    _statusSubscription = _ble.statusStream.listen((status) {
      _currentStatus = status;
      // If Bluetooth is turned off while scanning, stop the scan.
      if (status != BleStatus.ready) {
        stopScan();
      }
    });
  }
  // The main instance of the BLE library.
  final _ble = FlutterReactiveBle();

  // StreamControllers to manage and expose streams to the outside world.
  final _scannedDevicesController =
      StreamController<List<DiscoveredDevice>>.broadcast();
  final _isScanningController = StreamController<bool>.broadcast();

  // To manage active stream subscriptions.
  StreamSubscription<DiscoveredDevice>? _scanSubscription;
  StreamSubscription<BleStatus>? _statusSubscription;

  // Internal state variables used only within this class.
  final List<DiscoveredDevice> _internalDeviceList = [];
  late BleStatus _currentStatus = BleStatus.unknown;

  // A private boolean variable to track the scanning state.
  bool _isScanning = false;

  // --- PUBLIC STREAMS (THE EXTERNAL INTERFACE) ---

  /// A stream that reports the device's Bluetooth status (e.g., ready, poweredOff).
  Stream<BleStatus> get statusStream => _ble.statusStream;

  /// A stream that reports the updated list of discovered devices from a scan.
  Stream<List<DiscoveredDevice>> get scannedDevicesStream =>
      _scannedDevicesController.stream;

  /// A stream that reports whether scanning is active (true) or inactive (false).
  Stream<bool> get isScanningStream => _isScanningController.stream;

  // --- PUBLIC METHODS (CONTROL METHODS) ---

  /// Starts a scan for BLE devices.
  /// This will only work if the Bluetooth status is 'ready'.
  void startScan() {
    // Check the condition using the internal _isScanning variable.
    if (_isScanning || _currentStatus != BleStatus.ready) {
      return;
    }

    _internalDeviceList.clear();
    _scannedDevicesController.add([]); // Send an empty list to clear the UI

    // Update the scanning state and notify listeners via the stream.
    _isScanning = true;
    _isScanningController.add(true);

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
              _internalDeviceList[knownDeviceIndex] = device;
            } else {
              _internalDeviceList.add(device);
            }
            // Send an unmodifiable copy of the list to the stream.
            _scannedDevicesController.add(
              List.unmodifiable(_internalDeviceList),
            );
          },
          onError: (error) {
            // In production, use a logger instead of print.
            // print('Scan error: $error');
            stopScan();
          },
        );
  }

  /// Stops the currently active BLE device scan.
  void stopScan() {
    _scanSubscription?.cancel();
    _scanSubscription = null;

    // Only change the state and notify if a scan was actually active.
    if (_isScanning) {
      _isScanning = false;
      _isScanningController.add(false);
    }
  }

  /// Releases all resources when the manager is no longer needed.
  /// IT IS CRITICAL to call this method in the dispose() method of the widget that uses it.
  void dispose() {
    // print('BleManager disposed');
    _statusSubscription?.cancel();
    _scanSubscription?.cancel();
    _scannedDevicesController.close();
    _isScanningController.close();
  }
}
