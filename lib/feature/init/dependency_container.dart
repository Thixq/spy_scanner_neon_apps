import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:get_it/get_it.dart';
import 'package:pay/pay.dart';
import 'package:spy_scanner/feature/managers/ble_manager.dart';
import 'package:spy_scanner/feature/managers/host_scanner_manager.dart';
import 'package:spy_scanner/feature/managers/service_discovery_manager.dart';
import 'package:spy_scanner/feature/services/payment_service.dart';

final class DependencyContainer {
  DependencyContainer._init();

  void configure() {
    _configureService();
    _configureManager();
  }

  /// Singleton
  static final instance = DependencyContainer._init();

  static final GetIt _getIt = GetIt.instance;

  void _configureService() {
    _getIt.registerSingleton<PaymentService>(
      PaymentService(Pay({})),
    );
  }

  void _configureManager() {
    _getIt
      ..registerSingleton<BleManager>(BleManager(ble: FlutterReactiveBle()))
      ..registerSingleton<HostScanManager>(HostScanManager())
      ..registerSingleton<ServiceDiscoveryManager>(ServiceDiscoveryManager());
  }

  static T read<T extends Object>() => _getIt<T>();
  static Future<T> readAsync<T extends Object>() => _getIt.getAsync<T>();
}
