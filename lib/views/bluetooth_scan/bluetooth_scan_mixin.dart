part of 'bluetooth_scan_view.dart';

mixin _BluetoothScanMixin on State<BluetoothScanView> {
  late final ScrollController _scrollController;
  late final _BluetoothScanViewModel _viewModel;
  bool _isAtBottom = false;
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

  void _onScan() {
    _viewModel.add(_BluetoothScanEventStartScan());
  }

  void _onCancel() {
    _viewModel.add(_BluetoothScanEventStopScan());
  }

  @override
  void initState() {
    _viewModel = _BluetoothScanViewModel(
      bleScanner: DependencyInstances.manager.ble,
      bleStatusMonitor: DependencyInstances.monitoring.bluetooth,
    );
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
