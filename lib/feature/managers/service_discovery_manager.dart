import 'package:nsd/nsd.dart';

/// Manages mDNS/DNS-SD service discovery for multiple service types.
final class ServiceDiscoveryManager {
  ServiceDiscoveryManager({
    required this.serviceTypes,
    this.onServiceFound,
    this.onServiceRemoved,
  });

  /// List of service types to discover (e.g. '_http._tcp').
  final List<String> serviceTypes;

  /// Internal map of active discoveries keyed by service type.
  final Map<String, Discovery> _discoveries = {};

  /// Callback invoked when a service of a given type is discovered.
  final void Function(String type, Service service)? onServiceFound;

  /// Callback invoked when a previously discovered service is lost.
  final void Function(String type, Service service)? onServiceRemoved;

  /// Starts discovery for all configured service types.
  ///
  /// For each service type, a discovery is started and a listener is attached.
  Future<void> startAll() async {
    for (final type in serviceTypes) {
      final discovery = await startDiscovery(
        type,
        ipLookupType: IpLookupType.any,
      );

      _discoveries[type] = discovery;

      // Attach listener for found/lost events
      discovery.addServiceListener((service, serviceStatus) async {
        if (serviceStatus == ServiceStatus.found) {
          onServiceFound?.call(type, service);
        } else if (serviceStatus == ServiceStatus.lost) {
          onServiceRemoved?.call(type, service);
        }
      });

      print('✅ Discovery started for service type: $type');
    }
  }

  /// Stops all active discovery tasks and clears internal state.
  Future<void> stopAll() async {
    for (final discovery in _discoveries.values) {
      await stopDiscovery(discovery);
    }
    _discoveries.clear();
    print('🛑 All discovery tasks stopped.');
  }
}
