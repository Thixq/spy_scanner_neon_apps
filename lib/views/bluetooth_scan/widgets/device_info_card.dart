part of '../bluetooth_scan_view.dart';

class _DeviceInfoCard extends StatelessWidget {
  const _DeviceInfoCard({required this.result});
  final _DeviceResultModel result;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSizes.medium,
        ),
        title: Text('${result.title}'),
        subtitle: Text('${result.subtitle}'),
        trailing: Text('${result.trailing}'),
      ),
    );
  }
}
