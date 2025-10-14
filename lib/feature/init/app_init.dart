import 'package:dart_ping_ios/dart_ping_ios.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:network_tools/network_tools.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spy_scanner/core/logging/logging_manager.dart';
import 'package:spy_scanner/feature/init/dependency_container.dart';

final class AppConfig {
  const AppConfig._();
  static Future<void> init() async {
    await EasyLocalization.ensureInitialized();
    LoggingManager.init();
    await DependencyContainer.instance.configure();
    DartPingIOS.register();
    final appDocDirectory = await getApplicationDocumentsDirectory();
    await configureNetworkTools(appDocDirectory.path, enableDebugging: true);
  }
}
