part of '../bluetooth_scan_view.dart';

class _DeviceList extends StatelessWidget {
  const _DeviceList({
    required this.results,
  });
  final List<_DeviceResultModel> results;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final result = results[index];
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.medium,
            vertical: AppSizes.xSmall,
          ),
          child: _DeviceInfoCard(
            result: result,
          ),
        );
      },
    );
  }
}
