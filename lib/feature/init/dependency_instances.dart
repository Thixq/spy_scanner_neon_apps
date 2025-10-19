import 'package:spy_scanner/feature/init/dependency_container.dart';
import 'package:spy_scanner/feature/managers/ble_scanner_manager.dart';
import 'package:spy_scanner/feature/managers/host_scanner_manager.dart';
import 'package:spy_scanner/feature/managers/service_discovery_manager.dart';
import 'package:spy_scanner/feature/monitoring/bluetooth_status_monitor.dart';
import 'package:spy_scanner/feature/monitoring/wifi_status_monitor.dart';
import 'package:spy_scanner/feature/services/payment_service.dart';

final class DependencyInstances {
  const DependencyInstances._();

  static DependencyServices get service => const DependencyServices._();

  static DependencyMonitoring get monitoring => const DependencyMonitoring._();

  static DependencyManagers get manager => const DependencyManagers._();
}

final class DependencyServices {
  const DependencyServices._();

  PaymentService get payment => DependencyContainer.read<PaymentService>();
}

final class DependencyMonitoring {
  const DependencyMonitoring._();

  BluetoothStatusMonitor get bluetooth =>
      DependencyContainer.read<BluetoothStatusMonitor>();
  WifiStatusMonitor get wifi => DependencyContainer.read<WifiStatusMonitor>();
}

final class DependencyManagers {
  const DependencyManagers._();

  BleScannerManager get ble => DependencyContainer.read<BleScannerManager>();
  HostScanManager get hostScanner =>
      DependencyContainer.read<HostScanManager>();
  ServiceDiscoveryManager get serviceDiscovery =>
      DependencyContainer.read<ServiceDiscoveryManager>();
}
