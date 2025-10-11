// lib/ble_scanner_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:spy_scanner/feature/managers/ble_manager.dart'; // BleStatus enum'ı için

class BleScannerScreen extends StatefulWidget {
  const BleScannerScreen({super.key});

  @override
  State<BleScannerScreen> createState() => _BleScannerScreenState();
}

class _BleScannerScreenState extends State<BleScannerScreen> {
  // BleManager'ın bir örneğini oluşturuyoruz.
  // 'late final' kullanarak initState'de atanacağını belirtiyoruz.
  late final BleManager _bleManager;

  @override
  void initState() {
    super.initState();
    // Widget oluşturulduğunda manager'ı başlat.
    _bleManager = BleManager();
  }

  @override
  void dispose() {
    // Widget yok edildiğinde manager'daki kaynakları (stream'leri) temizle.
    // Bu adım, memory leak'leri önlemek için ÇOK ÖNEMLİDİR.
    _bleManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BLE Scanner'),
        actions: [
          // Tarama durumunu dinleyerek bir yüklenme göstergesi (indicator) ekle
          StreamBuilder<bool>(
            stream: _bleManager.isScanningStream,
            initialData: false,
            builder: (context, snapshot) {
              if (snapshot.data ?? false) {
                return const Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  ),
                );
              }
              return const SizedBox.shrink(); // Tarama yoksa boş
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Bluetooth durumunu gösteren alan
          StreamBuilder<BleStatus>(
            stream: _bleManager.statusStream,
            builder: (context, snapshot) {
              final status = snapshot.data ?? BleStatus.unknown;
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Bluetooth Status: ${status.name.toUpperCase()}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              );
            },
          ),
          const Divider(),
          // Bulunan cihazları listeleyen alan
          Expanded(
            child: StreamBuilder<List<DiscoveredDevice>>(
              stream: _bleManager.scannedDevicesStream,
              initialData: const [],
              builder: (context, snapshot) {
                final devices = snapshot.data ?? [];
                if (devices.isEmpty) {
                  return const Center(
                    child: Text('No devices found. Start scanning.'),
                  );
                }
                return ListView.builder(
                  itemCount: devices.length,
                  itemBuilder: (context, index) {
                    final device = devices[index];
                    return ListTile(
                      title: Text(
                        device.name.isNotEmpty ? device.name : 'Unknown Device',
                      ),
                      subtitle: Text('${device.id}\nRSSI: ${device.rssi} dBm'),
                      leading: const Icon(Icons.bluetooth),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      // Taramayı başlatıp/durduran Floating Action Button
      floatingActionButton: StreamBuilder<bool>(
        stream: _bleManager.isScanningStream,
        initialData: false,
        builder: (context, snapshot) {
          final isScanning = snapshot.data ?? false;
          return FloatingActionButton(
            onPressed: () async {
              if (isScanning) {
                await _bleManager.stopScan();
              } else {
                await _bleManager.startScan();
              }
            },
            child: Icon(isScanning ? Icons.stop : Icons.search),
          );
        },
      ),
    );
  }
}
