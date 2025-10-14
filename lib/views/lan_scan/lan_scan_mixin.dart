part of 'lan_scan_view.dart';

// TickerProvider kısıtlamasını tamamen kaldırıyoruz.
mixin _ScanMixin on State<LanScanView> {
  final String assetPath = LottieAssets.redSpy;
  final String _subnet = '192.168.1';

  void _onScan() {
    context.read<LanScanViewModel>().add(ScanEventStartScan(subnet: _subnet));
  }

  void _onCancel() {
    context.read<LanScanViewModel>().add(ScanEventStopScan());
  }
}
