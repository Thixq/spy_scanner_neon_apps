import 'package:flutter/material.dart';
import 'package:spy_scanner/core/logging/logging_manager.dart';
import 'package:spy_scanner/core/logging/zone_manager.dart';
import 'package:spy_scanner/dev/dev_component_view.dart';
import 'package:spy_scanner/feature/theme.dart';

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
      theme: SpyTheme.light(seedColor: const Color(0xFF697565)),
      darkTheme: SpyTheme.dark(seedColor: const Color(0xFF697565)),
      home: const DevComponentView(),
    );
  }
}
