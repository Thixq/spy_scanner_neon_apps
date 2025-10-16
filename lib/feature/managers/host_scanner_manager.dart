// ignore_for_file: discarded_futures, document_ignores

import 'dart:async';
import 'package:network_tools/network_tools.dart';
import 'package:spy_scanner/core/logging/custom_logger.dart'; // Varsayılan yol
import 'package:spy_scanner/core/logging/error_handler.dart';
import 'package:spy_scanner/feature/models/host_model.dart'; // Varsayılan yol

/// Simple DTO that can be given directly to the UI.
/// All fields are resolved to String.

/// Manager: listens to getAllPingableDevices(), resolves the Future fields
/// inside ActiveHost and publishes a list of HostView objects.
final class HostScanManager {
  /// Constructor
  HostScanManager();

  final ErrorHandler _errorHandler = ErrorHandler('HostScanManager');
  final CustomLogger _logger = CustomLogger('HostScanManager');

  final List<HostModel> _hosts = [];
  final StreamController<List<HostModel>> _hostsController =
      StreamController<List<HostModel>>.broadcast();
  Stream<List<HostModel>> get hostsStream => _hostsController.stream;
  StreamSubscription<ActiveHost>? _sub;
  bool _isScanning = false;
  bool get isScanning => _isScanning;
  Future<void> startScan(String subnet) async {
    if (_isScanning) {
      _logger.warning('Scan is already in progress. New scan request ignored.');
      return;
    }
    _isScanning = true;
    _hosts.clear();
    _hostsController.add(List.unmodifiable(_hosts));
    _logger.info('Starting host scan for subnet: $subnet');
    await _errorHandler.executeSafely(
      () async {
        _sub = HostScannerService.instance
            .getAllPingableDevices(subnet)
            .listen(
              _onHostFound,
              onError: (error, StackTrace stackTrace) {
                _logger.error(
                  'Error on scan stream',
                  error: error,
                  stackTrace: stackTrace,
                );
              },
              onDone: () {
                _isScanning = false;
                _hostsController.add(List.unmodifiable(_hosts));
                _logger.info('Scan completed. Found ${_hosts.length} hosts.');
              },
              cancelOnError: false,
            );
      },
      errorMessage: 'Failed to start scan',
      onError: (error, stackTrace) {
        _isScanning = false;
        _hostsController.add(List.unmodifiable(_hosts));
      },
    );
  }

  Future<void> _onHostFound(ActiveHost host) async {
    final initialHostModel = HostModel(
      id: host.hostId,
      address: host.address,
    );
    _hosts.add(initialHostModel);
    _hostsController.add(
      List.unmodifiable(_hosts),
    );
    _resolveAndBroadcastHostInfo(host, initialHostModel);
  }

  Future<void> _resolveAndBroadcastHostInfo(
    ActiveHost host,
    HostModel currentModel,
  ) async {
    final newModel = await _errorHandler.executeSafely<HostModel>(
      () async {
        await host.resolveInfo();
        final deviceName = await host.deviceName;
        final mac = await host.getMacAddress();
        final vendor = await host.vendor;
        return currentModel.copyWith(
          deviceName: deviceName,
          mac: mac,
          vendor: vendor?.vendorName ?? 'Unknown Vendor',
        );
      },
      errorMessage: 'Failed to resolve info for host: ${host.address}',
    );

    if (newModel != null) {
      final index = _hosts.indexWhere((h) => h.id == newModel.id);

      if (index != -1) {
        _hosts[index] = newModel;
        _hostsController.add(
          List.unmodifiable(_hosts),
        );
      }
    }
  }

  /// Cancel the running scan.
  Future<void> stopScan() async {
    if (!_isScanning) return;
    await _sub?.cancel();
    _sub = null;
    _isScanning = false;
    _hostsController.add(List.unmodifiable(_hosts));
    _logger.info('Scan stopped by user.');
  }

  /// Dispose resources to prevent memory leaks.
  void dispose() {
    _sub?.cancel();
    _hostsController.close();
    _logger.info('HostScanManager disposed.');
  }
}
