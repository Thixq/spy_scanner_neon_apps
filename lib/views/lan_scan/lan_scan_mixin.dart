part of 'lan_scan_view.dart';

// TickerProvider kısıtlamasını tamamen kaldırıyoruz.
mixin _ScanMixin on State<LanScanView> {
  final String assetPath = LottieAssets.redSpy;
  late final LanScanViewModel _viewModel;

  @override
  void initState() {
    _viewModel = LanScanViewModel(
      discoveryManager: DependencyInstances.manager.serviceDiscovery,
      hostScanManager: DependencyInstances.manager.hostScanner,
    );
    super.initState();
  }

  void _onScan(_ScanType scanType) {
    _viewModel.add(
      _ScanEventStartScan(scanType: scanType),
    );
  }

  void _onCancel(_ScanType scanType) {
    _viewModel.add(
      _ScanEventStopScan(scanType: scanType),
    );
  }
}
