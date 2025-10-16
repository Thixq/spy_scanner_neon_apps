import 'package:dart_ping_ios/dart_ping_ios.dart';
import 'package:flutter/material.dart';
import 'package:network_tools/network_tools.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spy_scanner/feature/managers/host_scanner_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPingIOS.register();
  final appDocDirectory = await getApplicationDocumentsDirectory();
  await configureNetworkTools(appDocDirectory.path, enableDebugging: true);
  runApp(
    const MaterialApp(
      home: DevHostScannerScreen(),
    ),
  );
}

class DevHostScannerScreen extends StatefulWidget {
  const DevHostScannerScreen({super.key});

  @override
  State<DevHostScannerScreen> createState() => _DevHostScannerScreenState();
}

class _DevHostScannerScreenState extends State<DevHostScannerScreen> {
  final HostScanManager _hostScanManager = HostScanManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _hostScanManager.startScan('192.168.1');
        },
      ),
      appBar: AppBar(
        title: const Text('Host Scanner'),
      ),
      body: StreamBuilder(
        stream: _hostScanManager.hostsStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final hosts = snapshot.data!;
            return ListView.builder(
              itemCount: hosts.length,
              itemBuilder: (context, index) {
                final host = hosts[index];
                return ListTile(
                  title: Text(host.address ?? 'N/A'),
                  subtitle: Text(host.deviceName ?? 'N/A'),
                  trailing: Text(host.mac ?? 'N/A'),
                  leading: Text(host.vendor ?? 'N/A'),
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
