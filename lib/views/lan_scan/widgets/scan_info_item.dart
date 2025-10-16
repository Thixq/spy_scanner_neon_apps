part of '../lan_scan_view.dart';

class _ScanInfoItem extends StatelessWidget {
  const _ScanInfoItem({required this.result});
  final _ScanResultModel result;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSizes.medium,
      ),
      title: Text('${result.title}'),
      subtitle: Text('${result.subtitle}'),
      trailing: Text('${result.trailing}'),
    );
  }
}
