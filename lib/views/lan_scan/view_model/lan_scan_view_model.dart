part of '../lan_scan_view.dart';

final class LanScanViewModel extends Bloc<_ScanlEvent, _ScanState> {
  LanScanViewModel({
    required ServiceDiscoveryManager discoveryManager,
    required HostScanManager hostScanManager,
    required FirebaseHostSaveManager hostSaveManager,
  }) : _hostScanManager = hostScanManager,
       _discoveryManager = discoveryManager,
       _hostSaveManager = hostSaveManager,
       super(const _IdleScanState(items: [])) {
    on<_ScanEventStartScan>(_startScan);
    on<_ScanEventStopScan>(_stopScan);
    on<_ScanSave>(
      (event, emit) async => saveHosts(),
    );
  }

  final HostScanManager _hostScanManager;
  final ServiceDiscoveryManager _discoveryManager;
  final FirebaseHostSaveManager _hostSaveManager;
  final List<HostModel> _hosts = [];

  Future<void> _startScan(
    _ScanEventStartScan event,
    Emitter<_ScanState> emit,
  ) async {
    if (event.scanType == _ScanType.host) {
      await _scanHost(event, emit);
    } else if (event.scanType == _ScanType.mdns) {
      await _scanMdns(event, emit);
    }
  }

  Future<void> saveHosts() async {
    await _hostSaveManager.saveHosts(
      userId: DependencyInstances.manager.profile.currentUser!.uid,
      subnet: '192.168.1',
      hosts: _hosts,
    );
  }

  Future<void> _scanMdns(
    _ScanEventStartScan event,
    Emitter<_ScanState> emit,
  ) async {
    final serviceTypes = [
      '_http._tcp',
      '_airplay._tcp',
      '_ftp._tcp',
      '_ssh._tcp',
    ];
    await _discoveryManager.start(serviceTypes: serviceTypes);
    await emit.onEach(
      _discoveryManager.discoveredServices,
      onData: (services) {
        final items = services
            .map(
              _MdnsModelImpl.new,
            )
            .toList();
        emit(_ScanningScanState(items: items, scanType: _ScanType.mdns));
      },
    );
  }

  Future<void> _scanHost(
    _ScanEventStartScan event,
    Emitter<_ScanState> emit,
  ) async {
    const subnet = '192.168.1';
    await _hostScanManager.startScan(subnet);
    await emit.onEach(
      _hostScanManager.hostsStream,
      onData: (hosts) {
        _hosts.addAll(hosts);
        final items = hosts
            .map(
              _HostModelImpl.new,
            )
            .toList();
        emit(_ScanningScanState(items: items, scanType: _ScanType.host));
      },
    );
  }

  Future<void> _stopScan(
    _ScanEventStopScan event,
    Emitter<_ScanState> emit,
  ) async {
    emit(_IdleScanState(items: state.items));

    if (event.scanType == _ScanType.host) {
      await _hostScanManager.stopScan();
    } else if (event.scanType == _ScanType.mdns) {
      await _discoveryManager.stopAll();
    }
  }

  @override
  Future<void> close() async {
    _hostScanManager.dispose();
    _discoveryManager.dispose();
    await super.close();
  }
}
