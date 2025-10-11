import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class BleScannerScreen extends StatefulWidget {
  const BleScannerScreen({super.key});

  @override
  _BleScannerScreenState createState() => _BleScannerScreenState();
}

class _BleScannerScreenState extends State<BleScannerScreen> {
  // BLE kütüphanesinin ana nesnesi
  final _ble = FlutterReactiveBle();

  // Cihazın BLE durumunu tutacak değişken
  late BleStatus _bleStatus = BleStatus.unknown;

  // Tarama sonucunda bulunan cihazların listesi
  final List<DiscoveredDevice> _foundDevices = [];

  // Aktif tarama işlemini yönetmek için stream aboneliği
  StreamSubscription<DiscoveredDevice>? _scanSubscription;

  @override
  void initState() {
    super.initState();
    // Widget başlarken BLE durumunu dinlemeye başla
    _listenToBleStatus();
  }

  @override
  void dispose() {
    // Widget sonlandığında taramayı durdur ve kaynakları serbest bırak
    _scanSubscription?.cancel();
    super.dispose();
  }

  // 1. Özellik: Cihazın BLE Durumunu Gözlemleme
  void _listenToBleStatus() {
    _ble.statusStream.listen((status) {
      setState(() {
        _bleStatus = status;
      });
      // Eğer Bluetooth hazırsa taramayı başlatabiliriz
      if (status == BleStatus.ready) {
        _startScan();
      }
    });
  }

  // 2. Özellik: Cihaz Keşfi (Tarama)
  void _startScan() {
    // Eski tarama sonuçlarını temizle
    setState(_foundDevices.clear);

    // Zaten aktif bir tarama varsa durdur
    _scanSubscription?.cancel();

    // Yeni taramayı başlat
    _scanSubscription = _ble
        .scanForDevices(
          withServices:
              [], // Belirli bir servis filtresi yok, tüm cihazları bul
          scanMode:
              ScanMode.lowLatency, // Enerji verimliliği ve hız arasında denge
        )
        .listen(
          (device) {
            // Bulunan her bir cihaz için bu kod çalışır
            setState(() {
              // Cihaz listede zaten var mı diye kontrol et
              final knownDeviceIndex = _foundDevices.indexWhere(
                (d) => d.id == device.id,
              );
              if (knownDeviceIndex >= 0) {
                // Varsa, bilgilerini güncelle (RSSI gibi)
                _foundDevices[knownDeviceIndex] = device;
              } else {
                // Yoksa, listeye ekle
                _foundDevices.add(device);
              }
            });
          },
          onError: (error) {
            // Hata durumunda konsola yazdır
            print('Tarama sırasında hata oluştu: $error');
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BLE Cihaz Tarayıcı'),
      ),
      body: Column(
        children: [
          // Mevcut BLE Durumunu gösteren alan
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Bluetooth Durumu: ${_bleStatus.name.toUpperCase()}',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          const Divider(),
          // Bulunan cihazların listesi
          Expanded(
            child: ListView.builder(
              itemCount: _foundDevices.length,
              itemBuilder: (context, index) {
                final device = _foundDevices[index];

                return ListTile(
                  title: Text(
                    device.name.isNotEmpty ? device.name : 'İsimsiz Cihaz',
                  ),
                  subtitle: Text('ID: ${device.id}\nRSSI: ${device.rssi} dBm'),
                  leading: const Icon(Icons.bluetooth),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Sadece Bluetooth hazırsa taramayı yeniden başlat
          if (_bleStatus == BleStatus.ready) {
            _startScan();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Bluetooth kapalı veya yetki verilmemiş.'),
              ),
            );
          }
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}
