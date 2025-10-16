import 'dart:async';
import 'package:nsd/nsd.dart';
import 'package:spy_scanner/core/logging/custom_logger.dart';
import 'package:spy_scanner/core/logging/error_handler.dart';
import 'package:spy_scanner/feature/models/mdns_service_model.dart';
import 'package:uuid/v8.dart';

typedef ServiceCallback = void Function(String type, Service service);

final class ServiceDiscoveryManager {
  ServiceDiscoveryManager();

  final _logger = CustomLogger('ServiceDiscoveryManager');
  final _errorHandler = ErrorHandler('ServiceDiscoveryManager');

  final Map<String, Discovery> _discoveries = {};
  final List<MdnsServiceModel> _discoveredServices = [];
  final StreamController<List<MdnsServiceModel>> _discoveredServicesController =
      StreamController<List<MdnsServiceModel>>.broadcast();

  Stream<List<MdnsServiceModel>> get discoveredServices =>
      _discoveredServicesController.stream;

  Future<void> start({
    required List<String> serviceTypes,
  }) async {
    for (final type in serviceTypes) {
      await _errorHandler.executeSafely(
        () async {
          final discovery = await startDiscovery(
            type,
            ipLookupType: IpLookupType.any,
          );

          _discoveries[type] = discovery;
          discovery.addServiceListener(_serviceListener);
        },
        errorMessage: 'Failed to start discovery for service type: $type',
      );

      _logger.info('✅ Discovery started for service type: $type');
    }
    _publishCurrent();
  }

  Future<void> _serviceListener(
    Service service,
    ServiceStatus serviceStatus,
  ) async {
    await _errorHandler.executeSafely(() async {
      switch (serviceStatus) {
        case ServiceStatus.found:
          final index = _discoveredServices.indexWhere(
            (s) => s.name == service.name && s.type == service.type,
          );

          if (index == -1) {
            final newService = MdnsServiceModel(
              id: const UuidV8().generate(),
              type: service.type,
              name: service.name,
              addresses: service.addresses?.map((e) => e.address).toList(),
              port: service.port,
            );
            _discoveredServices.add(newService);
            _logger.info('✅ Service found: ${newService.name}');
          } else {
            final existing = _discoveredServices[index];
            final updated = existing.copyWith(
              addresses: service.addresses?.map((e) => e.address).toList(),
              port: service.port,
            );
            _discoveredServices[index] = updated;
            _logger.info('♻️ Service updated: ${existing.name}');
          }

        case ServiceStatus.lost:
          _discoveredServices.removeWhere(
            (s) => s.name == service.name && s.type == service.type,
          );
          _logger.warning('⚠️ Service lost: ${service.name}');
      }

      _publishCurrent();
    }, errorMessage: 'Failed to handle service discovery event');
  }

  void _publishCurrent() {
    if (!_discoveredServicesController.isClosed) {
      _discoveredServicesController.add(
        List.unmodifiable(_discoveredServices),
      );
    }
  }

  Future<void> stopAll() async {
    for (final discovery in _discoveries.values) {
      await _errorHandler.executeSafely(
        () async {
          discovery.removeServiceListener(_serviceListener);
          await stopDiscovery(discovery);
        },
        errorMessage: 'Failed to stop a discovery task',
      );
    }
    _discoveries.clear();
    _logger.info('🛑 All discovery tasks stopped.');
  }

  /// Dispose artık async — çağıran await etmelidir.
  void dispose() {
    stopAll();
    _discoveredServicesController.close();
    _logger.info('ServiceDiscoveryManager disposed.');
  }
}
