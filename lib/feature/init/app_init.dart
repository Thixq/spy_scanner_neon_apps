import 'package:easy_localization/easy_localization.dart';
import 'package:spy_scanner/core/logging/logging_manager.dart';
import 'package:spy_scanner/feature/init/dependency_container.dart';

final class AppConfig {
  const AppConfig._();
  static Future<void> init() async {
    await EasyLocalization.ensureInitialized();
    LoggingManager.init();
    await DependencyContainer.instance.configure();
  }
}
