// ignore_for_file: discarded_futures, document_ignores

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:nsd/nsd.dart';
// Kendi dosyalarınızı buraya ekleyin

import 'package:spy_scanner/feature/managers/service_discovery_manager.dart';

// ServiceDiscoveryManager sınıfınızı yeniden tanımladım,
// çünkü bu kodun çalışması için gerekli.

// --------------------------------------------------------------------------

// Örnek olarak aranacak hizmet tipleri
const List<String> _serviceTypesToDiscover = [
  '_http._tcp',
  '_airplay._tcp',
];

@RoutePage()
class ServiceDiscoveryView extends StatefulWidget {
  const ServiceDiscoveryView({super.key});

  @override
  State<ServiceDiscoveryView> createState() => _ServiceDiscoveryViewState();
}

class _ServiceDiscoveryViewState extends State<ServiceDiscoveryView> {
  final ServiceDiscoveryManager _manager = ServiceDiscoveryManager();
  final Map<String, Service> _discoveredServices = {};
  bool _isDiscovering = false;

  @override
  void initState() {
    super.initState();
    _startDiscovery();
  }

  // --- Hata Giderilen Kısımlar: mounted Kontrolü Eklendi ---

  Future<void> _startDiscovery() async {
    // Başlatmadan önce de mounted kontrolü yapılabilir, ancak initState'te
    // çağrıldığı için genellikle gereksizdir. Yine de güvenli bir kodlama pratiği
    // için ekledik.
    if (!mounted) return;

    setState(() {
      _isDiscovering = true;
      _discoveredServices.clear();
    });

    // Keşif işlemini başlatır ve listener'ları ekler
    await _manager.startAll(
      serviceTypes: _serviceTypesToDiscover,
      onServiceFound: _onServiceFound,
      onServiceRemoved: _onServiceRemoved,
    );

    if (mounted) {
      setState(() {
        _isDiscovering = true;
      });
    }
  }

  Future<void> _stopDiscovery() async {
    // Önce keşfi durdurur
    await _manager.stopAll();

    // Hata çözümü: setState çağırmadan önce mounted kontrolü yapın!
    if (mounted) {
      setState(() {
        _isDiscovering = false;
      });
    }
  }

  // --- Geri Çağırım Fonksiyonları (CALLBACKS) ---
  // Hata çözümü: Asenkron callback'lerin içinde setState çağırmadan önce mounted kontrolü yapın!

  void _onServiceFound(String type, Service service) {
    if (!mounted) {
      // Widget ağaçtan kaldırıldı, setState yapma.
      return;
    }

    final key = '${service.name}@$type';
    setState(() {
      _discoveredServices[key] = service;
    });
  }

  void _onServiceRemoved(String type, Service service) {
    if (!mounted) {
      // Widget ağaçtan kaldırıldı, setState yapma.
      return;
    }

    final key = '${service.name}@$type';
    setState(() {
      _discoveredServices.remove(key);
    });
  }

  // --- Temizlik ---

  @override
  void dispose() {
    // Sayfa kapandığında, listener'ların çalışmasını durdurun.
    // Bu, nsd paketinin kütüphane seviyesinde listener'ları kaldırır.
    _stopDiscovery();
    super.dispose();
  }

  // --- Arayüz (UI) Yapısı ---

  @override
  Widget build(BuildContext context) {
    // UI kodunun geri kalanı değişmedi
    return Scaffold(
      appBar: AppBar(
        title: const Text('mDNS Hizmet Keşfi'),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: Icon(_isDiscovering ? Icons.stop : Icons.play_arrow),
            onPressed: _isDiscovering ? _stopDiscovery : _startDiscovery,
            tooltip: _isDiscovering ? 'Keşfi Durdur' : 'Keşfi Başlat',
          ),
        ],
      ),
      body: Column(
        children: [
          _buildStatusHeader(),
          const Divider(),
          Expanded(
            child: _buildServiceList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isDiscovering ? _stopDiscovery : _startDiscovery,
        child: Icon(_isDiscovering ? Icons.stop : Icons.search),
      ),
    );
  }

  Widget _buildStatusHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(
            _isDiscovering ? Icons.circle : Icons.stop_circle_outlined,
            color: _isDiscovering ? Colors.green : Colors.red,
            size: 16,
          ),
          const SizedBox(width: 8),
          Text(
            _isDiscovering ? 'Hizmetler aranıyor...' : 'Keşif Durdu',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: _isDiscovering ? Colors.green : Colors.red,
            ),
          ),
          const Spacer(),
          Text('Toplam Hizmet: ${_discoveredServices.length}'),
        ],
      ),
    );
  }

  Widget _buildServiceList() {
    if (_discoveredServices.isEmpty) {
      return Center(
        child: Text(
          _isDiscovering
              ? 'Hizmetler aranıyor: ${_serviceTypesToDiscover.join(', ')}'
              : 'Keşif durduruldu veya hiç hizmet bulunamadı.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey[600]),
        ),
      );
    }

    final services = _discoveredServices.values.toList();

    return ListView.builder(
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        final key = _discoveredServices.keys.firstWhere(
          (k) => _discoveredServices[k] == service,
        );
        final serviceType = key.split('@').last;

        final address = service.addresses?.isNotEmpty ?? false
            ? service.addresses!.first
            : 'Bilinmiyor';
        final port = service.port ?? 'Bilinmiyor';

        return ListTile(
          leading: const Icon(Icons.wifi_tethering),
          title: Text(
            service.name ?? 'Adsız Hizmet',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text('Tip: $serviceType\nAdres: $address:$port'),
          isThreeLine: true,
          trailing: const Icon(Icons.info_outline),
          onTap: () async {
            await _showServiceDetails(service, serviceType);
          },
        );
      },
    );
  }

  Future<void> _showServiceDetails(Service service, String serviceType) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(service.name ?? 'Hizmet Detayları'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Tip: $serviceType'),
                Text('Port: ${service.port ?? 'Bilinmiyor'}'),
                const Divider(),
                const Text('Adresler:'),
                ...service.addresses!.map((a) => Text(a.address)),
                const Divider(),
                const Text('TXT Kayıtları:'),
                ...?service.txt?.entries.map(
                  (e) => Text(
                    '${e.key}: ${e.value != null ? String.fromCharCodes(e.value!) : 'null'}',
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Kapat'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
