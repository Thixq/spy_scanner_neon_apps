import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:get_it/get_it.dart';
import 'package:spy_scanner/feature/managers/ble_manager.dart';
import 'package:spy_scanner/feature/managers/host_scanner_manager.dart';
import 'package:spy_scanner/feature/managers/service_discovery_manager.dart';

final class DependencyManager {
  DependencyManager._init();

  void configure() {
    _configureManager();
  }

  /// Singleton
  static final instance = DependencyManager._init();

  static final GetIt _getIt = GetIt.instance;

  void _configureManager() {
    _getIt
      ..registerSingleton<BleManager>(BleManager(ble: FlutterReactiveBle()))
      ..registerSingleton<HostScanManager>(HostScanManager())
      ..registerSingleton<ServiceDiscoveryManager>(ServiceDiscoveryManager());
  }
}
