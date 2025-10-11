import 'package:nsd/nsd.dart';
import 'package:spy_scanner/core/logging/custom_logger.dart';
import 'package:spy_scanner/core/logging/error_handler.dart';

typedef ServiceCallback = void Function(String type, Service service);

/// Manages mDNS/DNS-SD service discovery for multiple service types.
final class ServiceDiscoveryManager {
  ServiceDiscoveryManager();

  final _logger = CustomLogger('ServiceDiscoveryManager');
  final _errorHandler = ErrorHandler('ServiceDiscoveryManager');

  /// Internal map of active discoveries keyed by service type.
  final Map<String, Discovery> _discoveries = {};

  /// Starts discovery for all configured service types.
  ///
  /// For each service type, a discovery is started and a listener is attached.
  ///
  /// The [onServiceFound] and [onServiceRemoved] callbacks are invoked
  /// when services are found or lost, respectively.
  ///
  /// [serviceTypes] is a list of service type strings (e.g., "_http._tcp").
  Future<void> startAll({
    required List<String> serviceTypes,
    ServiceCallback? onServiceFound,
    ServiceCallback? onServiceRemoved,
  }) async {
    for (final type in serviceTypes) {
      await _errorHandler.executeSafely(
        () async {
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
        },
        errorMessage: 'Failed to start discovery for service type: $type',
      );

      _logger.info('✅ Discovery started for service type: $type');
    }
  }

  /// Stops all active discovery tasks and clears internal state.
  Future<void> stopAll() async {
    for (final discovery in _discoveries.values) {
      await _errorHandler.executeSafely(
        () async {
          await stopDiscovery(discovery);
        },
        errorMessage: 'Failed to stop a discovery task',
      );
    }
    _discoveries.clear();
    _logger.info('🛑 All discovery tasks stopped.');
  }
}
