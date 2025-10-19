// ignore_for_file: document_ignores

import 'dart:async';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:spy_scanner/core/logging/custom_logger.dart';

/// Monitors the Bluetooth adapter status and provides a stream of changes.
final class BluetoothStatusMonitor {
  BluetoothStatusMonitor({required FlutterReactiveBle ble}) : _ble = ble {
    _statusSubscription = _ble.statusStream.listen((status) {
      _logger.info('Bluetooth status changed: $status');
      _currentStatus = status;
    });
    _logger.info('BluetoothStatusMonitor initialized.');
  }

  final _logger = CustomLogger('BluetoothStatusMonitor');

  final FlutterReactiveBle _ble;
  late BleStatus _currentStatus = BleStatus.unknown;
  StreamSubscription<BleStatus>? _statusSubscription;

  /// Gets the stream of Bluetooth adapter status changes.
  Stream<BleStatus> get statusStream => _ble.statusStream;

  /// Gets the current status of the Bluetooth adapter.
  BleStatus get currentStatus => _currentStatus;

  /// Releases the status stream subscription.
  void dispose() {
    _statusSubscription?.cancel();
    _logger.info('BluetoothStatusMonitor disposed.');
  }
}
