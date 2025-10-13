import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spy_scanner/core/logging/logging_manager.dart';
import 'package:spy_scanner/core/logging/zone_manager.dart';
import 'package:spy_scanner/feature/localization/localization_app.dart';
import 'package:spy_scanner/feature/routing/app_routing.dart';
import 'package:spy_scanner/feature/theme.dart';

Future<void> main() async {
  await ZoneManager.runAppInZone(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
    LoggingManager.init();
    runApp(LocalizationApp(child: const MyApp()));
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
