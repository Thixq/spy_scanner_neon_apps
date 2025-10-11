import 'dart:async';
import 'package:network_tools/network_tools.dart';

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
class HostScanManager {
  final List<HostView> _hosts = [];
  final StreamController<List<HostView>> _hostsController =
      StreamController<List<HostView>>.broadcast();

  /// Stream of resolved hosts for UI consumption.
  Stream<List<HostView>> get hostsStream => _hostsController.stream;

  StreamSubscription<ActiveHost>? _sub;
  bool _isScanning = false;
  bool get isScanning => _isScanning;

  /// Start scan — a second scan will not be started while one is already running.
  Future<void> startScan(String subnet) async {
    if (_isScanning) return;
    _isScanning = true;
    _hosts.clear();
    _hostsController.add(List.unmodifiable(_hosts));

    try {
      _sub = HostScannerService.instance
          .getAllPingableDevices(
            subnet,
            // Optional parameters:
            // firstHostId: 1, lastHostId: 254, timeoutInSeconds: 1,
          )
          .listen(
            (ActiveHost host) async {
              // Resolve async fields for each host
              try {
                // resolveInfo will resolve arp/deviceName/hostName/mdns partially
                await host.resolveInfo();

                // deviceName: Future<String>
                final deviceName = await host.deviceName;

                // getMacAddress() returns an async string
                final mac = (await host.getMacAddress()) ?? 'N/A';

                // vendor: Future<Vendor?> -> vendorName
                final v = await host.vendor;
                final vendorName = v?.vendorName ?? 'Unknown Vendor';

                final view = HostView(
                  address: host.address,
                  deviceName: deviceName,
                  mac: mac,
                  vendor: vendorName,
                );

                _hosts.add(view);
                _hostsController.add(List.unmodifiable(_hosts));
              } catch (e, st) {
                // If resolving one host fails, the scan should continue.
                // You can replace the print with your project's logger.
                // ignore: avoid_print
                print('Host resolve error for ${host.address}: $e\n$st');
              }
            },
            onError: (e, st) {
              // Notifies when an error occurs on the scan stream.
              // ignore: avoid_print
              print('Scan stream error: $e\n$st');
            },
            onDone: () {
              _isScanning = false;
              _hostsController.add(List.unmodifiable(_hosts));
              // ignore: avoid_print
              print('Scan completed. Found ${_hosts.length} hosts.');
            },
            cancelOnError: false,
          );
    } catch (e, st) {
      _isScanning = false;
      _hostsController.add(List.unmodifiable(_hosts));
      // ignore: avoid_print
      print('Failed to start scan: $e\n$st');
    }
  }

  /// Cancel the running scan.
  Future<void> stopScan() async {
    await _sub?.cancel();
    _sub = null;
    _isScanning = false;
    _hostsController.add(List.unmodifiable(_hosts));
  }

  void dispose() {
    _sub?.cancel();
    _hostsController.close();
  }
}
