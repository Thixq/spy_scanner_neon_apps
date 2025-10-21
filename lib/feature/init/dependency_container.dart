import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:get_it/get_it.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:pay/pay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spy_scanner/feature/constants/payment_assets.dart';
import 'package:spy_scanner/feature/managers/account_manager.dart';
import 'package:spy_scanner/feature/managers/ble_scanner_manager.dart';
import 'package:spy_scanner/feature/managers/host_scanner_manager.dart';
import 'package:spy_scanner/feature/managers/service_discovery_manager.dart';
import 'package:spy_scanner/feature/monitoring/bluetooth_status_monitor.dart';
import 'package:spy_scanner/feature/monitoring/wifi_status_monitor.dart';
import 'package:spy_scanner/feature/services/payment_service.dart';

final class DependencyContainer {
  DependencyContainer._();

  Future<void> configure() async {
    _configureService();
    _configureMonitor();
    _configureManager();
    await _getIt.allReady();
  }

  /// Singleton
  static final instance = DependencyContainer._();

  static final GetIt _getIt = GetIt.instance;

  void _configureService() {
    _getIt
      ..registerSingletonAsync<PaymentService>(
        () async {
          final googleConfig = await PaymentConfiguration.fromAsset(
            PaymentAssets.devGooglePlay,
          );

          final appleConfig = await PaymentConfiguration.fromAsset(
            PaymentAssets.devAppleStore,
          );

          return PaymentService(
            Pay({
              PayProvider.google_pay: googleConfig,
              PayProvider.apple_pay: appleConfig,
            }),
          );
        },
      )
      ..registerSingletonAsync<SharedPreferences>(
        () async => SharedPreferences.getInstance(),
      );
  }

  void _configureManager() {
    _getIt
      ..registerSingleton<BleScannerManager>(
        BleScannerManager(ble: FlutterReactiveBle()),
      )
      ..registerSingleton<HostScanManager>(HostScanManager())
      ..registerSingleton<ServiceDiscoveryManager>(ServiceDiscoveryManager())
      ..registerSingletonAsync<AccountManager>(
        () async =>
            AccountManager(preferences: _getIt.get<SharedPreferences>()),
        dependsOn: [SharedPreferences],
      );
  }

  void _configureMonitor() {
    _getIt
      ..registerSingleton<BluetoothStatusMonitor>(
        BluetoothStatusMonitor(ble: FlutterReactiveBle()),
      )
      ..registerSingleton<WifiStatusMonitor>(
        WifiStatusMonitor(
          connectivity: Connectivity(),
          networkInfo: NetworkInfo(),
        ),
      );
  }

  static T read<T extends Object>() => _getIt<T>();
  static Future<T> readAsync<T extends Object>() => _getIt.getAsync<T>();
}
