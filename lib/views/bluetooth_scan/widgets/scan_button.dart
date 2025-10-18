part of '../bluetooth_scan_view.dart';

final String idleButtonText = LocaleKeys.views_bluetooth_scan_scan_text.tr();
final String cancelButtonText = LocaleKeys.views_bluetooth_scan_scan_cancel_text
    .tr();

class _ScanButton extends StatelessWidget {
  const _ScanButton({
    required this.isScanning,
    this.onScan,
    this.onCancel,
  });
  final bool isScanning;
  final VoidCallback? onScan;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentGeometry.bottomCenter,
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: isScanning ? onCancel : onScan,
            child: Text(
              isScanning ? cancelButtonText : idleButtonText,
            ),
          ),
        ),
      ),
    );
  }
}
