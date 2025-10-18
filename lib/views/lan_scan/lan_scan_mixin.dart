part of 'lan_scan_view.dart';

// TickerProvider kısıtlamasını tamamen kaldırıyoruz.
mixin _ScanMixin on State<LanScanView> {
  final String assetPath = LottieAssets.redSpy;
  late final LanScanViewModel _viewModel;
  late final ScrollController _scrollController;
  bool _isAtBottom = false;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _viewModel = LanScanViewModel(
      discoveryManager: DependencyInstances.manager.serviceDiscovery,
      hostScanManager: DependencyInstances.manager.hostScanner,
    );
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Scroll’un en altına inildiyse
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 50) {
      if (!_isAtBottom) {
        setState(() => _isAtBottom = true);
      }
    } else {
      if (_isAtBottom) {
        setState(() => _isAtBottom = false);
      }
    }
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
