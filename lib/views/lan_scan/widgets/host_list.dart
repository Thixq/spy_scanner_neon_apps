part of '../lan_scan_view.dart';

class _HostList extends StatelessWidget {
  const _HostList({
    required this.results,
  });
  final List<_ScanResultModel> results;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final result = results[index];
        return _ScanInfoItem(result: result);
      },
    );
  }
}
