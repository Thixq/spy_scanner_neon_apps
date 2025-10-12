import 'package:flutter/material.dart';
import 'package:spy_scanner/core/logging/logging_manager.dart';
import 'package:spy_scanner/core/logging/zone_manager.dart';

import 'package:spy_scanner/dev/dev_onboard_view.dart';
import 'package:spy_scanner/feature/theme.dart';
import 'package:spy_scanner/views/onboard_view/onboard_view.dart';

Future<void> main() async {
  await ZoneManager.runAppInZone(() async {
    WidgetsFlutterBinding.ensureInitialized();
    LoggingManager.init();
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spy Scanner',
      theme: SpyTheme.light(seedColor: const Color(0xFFDD0303)),
      darkTheme: SpyTheme.dark(seedColor: const Color(0xFFDD0303)),
      home: const OnboardView(),
    );
  }
}
