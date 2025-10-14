part of '../lan_scan_view.dart';

final String _scanIdleButtonText = LocaleKeys.views_lan_scan_scan_idle_text
    .tr();
final String _scanCancelButtonText = LocaleKeys.views_lan_scan_scan_cancel_text
    .tr();

class _ScanButton extends StatelessWidget {
  const _ScanButton({
    required this.isScanning,
    required this.onScan,
    required this.onCancel,
  });
  final bool isScanning;
  final void Function() onScan;
  final void Function() onCancel;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentGeometry.bottomCenter,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.medium,
          ),
          child: SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: isScanning ? onCancel : onScan,
              child: Text(
                isScanning ? _scanCancelButtonText : _scanIdleButtonText,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
