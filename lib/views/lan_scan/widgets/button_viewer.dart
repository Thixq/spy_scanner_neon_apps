part of '../lan_scan_view.dart';

final String _hostScan = LocaleKeys.views_lan_scan_scan_host_text.tr();
final String _mdnsScan = LocaleKeys.views_lan_scan_scan_mdns_text.tr();
final String _cancelScan = LocaleKeys.views_lan_scan_scan_cancel_text.tr();

class _ButtonViewer extends StatelessWidget {
  const _ButtonViewer({
    required this.onScan,
    required this.onCancel,
    required this.isScanning,
    required this.scanType,
  });

  final ValueChanged<_ScanType> onScan;
  final ValueChanged<_ScanType> onCancel;

  final bool isScanning;
  final _ScanType? scanType;

  @override
  Widget build(BuildContext context) {
    final isLanScanning = isScanning && scanType == _ScanType.host;
    final isMdnsScanning = isScanning && scanType == _ScanType.mdns;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.large),
      child: Row(
        spacing: AppSizes.small,
        children: [
          // LAN Scan Button
          Flexible(
            child: _ScanButton(
              isScanning: isLanScanning,
              onScan: isMdnsScanning ? null : () => onScan.call(_ScanType.host),
              onCancel: () => onCancel.call(_ScanType.host),
              idleButtonText: _hostScan,
              cancelButtonText: _cancelScan,
            ),
          ),

          // mDNS Scan Button
          Flexible(
            child: _ScanButton(
              isScanning: isMdnsScanning,
              onScan: isLanScanning ? null : () => onScan.call(_ScanType.mdns),
              onCancel: () => onCancel.call(_ScanType.mdns),
              idleButtonText: _mdnsScan,
              cancelButtonText: _cancelScan,
            ),
          ),
        ],
      ),
    );
  }
}
