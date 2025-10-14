import 'package:spy_scanner/feature/init/dependency_container.dart';
import 'package:spy_scanner/feature/managers/ble_manager.dart';
import 'package:spy_scanner/feature/managers/host_scanner_manager.dart';
import 'package:spy_scanner/feature/managers/service_discovery_manager.dart';
import 'package:spy_scanner/feature/services/payment_service.dart';

final class DependencyInstances {
  const DependencyInstances._();

  DependencyServices get service => const DependencyServices._();

  DependencyManagers get manager => const DependencyManagers._();
}

final class DependencyServices {
  const DependencyServices._();

  PaymentService get payment => DependencyContainer.read<PaymentService>();
}

final class DependencyManagers {
  const DependencyManagers._();

  BleManager get ble => DependencyContainer.read<BleManager>();
  HostScanManager get hostScanner =>
      DependencyContainer.read<HostScanManager>();
  ServiceDiscoveryManager get serviceDiscovery =>
      DependencyContainer.read<ServiceDiscoveryManager>();
}
