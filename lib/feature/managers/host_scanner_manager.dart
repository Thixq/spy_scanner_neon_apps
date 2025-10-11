// ignore_for_file: discarded_futures, document_ignores

import 'dart:async';
import 'package:network_tools/network_tools.dart';
import 'package:spy_scanner/core/logging/custom_logger.dart'; // Varsayılan yol
import 'package:spy_scanner/core/logging/error_handler.dart'; // Varsayılan yol

/// Simple DTO that can be given directly to the UI.
/// All fields are resolved to String.
class HostView {
  HostView({
    required this.address,
    required this.deviceName,
    required this.mac,
    required this.vendor,
  });
  final String address;
  final String deviceName;
  final String mac;
  final String vendor;
}

/// Manager: listens to getAllPingableDevices(), resolves the Future fields
/// inside ActiveHost and publishes a list of HostView objects.
final class HostScanManager {
  // Hem operasyon sarmalama hem de genel loglama için gerekli sınıflar.
  final ErrorHandler _errorHandler = ErrorHandler('HostScanManager');
  final CustomLogger _logger = CustomLogger('HostScanManager');

  final List<HostView> _hosts = [];
  final StreamController<List<HostView>> _hostsController =
      StreamController<List<HostView>>.broadcast();

  Stream<List<HostView>> get hostsStream => _hostsController.stream;

  StreamSubscription<ActiveHost>? _sub;
  bool _isScanning = false;
  bool get isScanning => _isScanning;

  /// Start scan — uses ErrorHandler to manage initialization and processing.
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
              _onHostFound, // Ayrı bir metoda taşıyarak okunabilirliği artırdık.
              onError: (error, StackTrace stackTrace) {
                // Stream'in kendisinden gelen bir hatayı logluyoruz.
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

  /// Handles each discovered ActiveHost from the stream.
  Future<void> _onHostFound(ActiveHost host) async {
    final hostView = await _errorHandler.executeSafely<HostView>(
      () async {
        await host.resolveInfo();
        final deviceName = await host.deviceName;
        final mac = await host.getMacAddress() ?? 'N/A';
        final vendor = await host.vendor;

        return HostView(
          address: host.address,
          deviceName: deviceName,
          mac: mac,
          vendor: vendor?.vendorName ?? 'Unknown Vendor',
        );
      },

      errorMessage: 'Failed to resolve info for host: ${host.address}',
    );

    if (hostView != null) {
      _hosts.add(hostView);
      _hostsController.add(List.unmodifiable(_hosts));
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
