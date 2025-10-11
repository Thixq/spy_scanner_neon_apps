import 'package:flutter/material.dart';
import 'package:spy_scanner/core/logging/logging_manager.dart';
import 'package:spy_scanner/core/logging/zone_manager.dart';
import 'package:spy_scanner/dev/dev_component_view.dart';
import 'package:spy_scanner/feature/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ZoneManager.runAppInZone(() async {
    LoggingManager.init();
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BLE Manager Example',
      theme: SpyTheme.light(seedColor: Colors.blue),
      darkTheme: SpyTheme.dark(seedColor: Colors.blue),
      home: const DevComponentView(),
    );
  }
}
