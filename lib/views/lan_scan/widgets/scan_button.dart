part of '../lan_scan_view.dart';

class _ScanButton extends StatelessWidget {
  const _ScanButton({
    required this.isScanning,
    required this.idleButtonText,
    required this.cancelButtonText,
    this.onScan,
    this.onCancel,
  });
  final bool isScanning;
  final String idleButtonText;
  final String cancelButtonText;
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
