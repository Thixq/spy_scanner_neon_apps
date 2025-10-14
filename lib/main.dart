import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spy_scanner/core/logging/zone_manager.dart';
import 'package:spy_scanner/feature/init/app_init.dart';
import 'package:spy_scanner/feature/init/dependency_instances.dart';
import 'package:spy_scanner/feature/localization/localization_app.dart';
import 'package:spy_scanner/feature/routing/app_routing.dart';
import 'package:spy_scanner/feature/theme.dart';
import 'package:spy_scanner/views/lan_scan/view_model/scan_view_model.dart';

Future<void> main() async {
  await ZoneManager.runAppInZone(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await AppConfig.init();
    runApp(
      LocalizationApp(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => LanScanViewModel(
                hostScanManager: DependencyInstances.manager.hostScanner,
              ),
            ),
          ],
          child: const MyApp(),
        ),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Spy Scanner',
      theme: SpyTheme.light(),
      darkTheme: SpyTheme.dark(),
      routerConfig: AppRouting.instance.config(),
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
    );
  }
}
