part of '../lan_scan_view.dart';

final String _ipAddress = LocaleKeys.views_lan_scan_host_info_card_ip_address
    .tr();

final String _deviceName = LocaleKeys.views_lan_scan_host_info_card_device_name
    .tr();
final String _macAddress = LocaleKeys.views_lan_scan_host_info_card_mac_address
    .tr();

class _HostInfoItem extends StatelessWidget {
  const _HostInfoItem({required this.host});
  final HostModel host;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSizes.medium,
      ),
      title: Text('$_ipAddress${host.address}'),
      subtitle: Text('$_deviceName ${host.deviceName}'),
      trailing: Text('$_macAddress ${host.mac}'),
    );
  }
}
