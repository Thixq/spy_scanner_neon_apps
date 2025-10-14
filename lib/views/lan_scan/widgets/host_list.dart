part of '../lan_scan_view.dart';

class _HostList extends StatelessWidget {
  const _HostList({required this.hostList});
  final List<HostModel> hostList;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: hostList.length,
      itemBuilder: (context, index) {
        final host = hostList[index];
        return _HostInfoItem(host: host);
      },
    );
  }
}
