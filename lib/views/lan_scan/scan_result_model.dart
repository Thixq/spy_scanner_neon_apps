part of 'lan_scan_view.dart';

sealed class _ScanResultModel extends Equatable {
  String? get title;
  String? get subtitle;
  String? get trailing;

  @override
  List<Object?> get props => [title, subtitle, trailing];
}

final class _HostModelImpl extends _ScanResultModel {
  _HostModelImpl(this.hostModel);

  final HostModel hostModel;

  final String _titleLoc = LocaleKeys.views_lan_scan_host_info_result_ip_address
      .tr();
  final String _subTitleLoc = LocaleKeys
      .views_lan_scan_host_info_result_device_name
      .tr();
  final String _trailingLoc = LocaleKeys
      .views_lan_scan_host_info_result_mac_address
      .tr();

  @override
  String? get subtitle => '$_subTitleLoc${hostModel.deviceName}';

  @override
  String? get title => '$_titleLoc${hostModel.address ?? 'N/A'}';

  @override
  String? get trailing => '$_trailingLoc${hostModel.mac ?? 'N/A'}';
}

final class _MdnsModelImpl extends _ScanResultModel {
  _MdnsModelImpl(this.mdnsModel);

  final MdnsServiceModel mdnsModel;

  final String _titleLoc = LocaleKeys
      .views_lan_scan_mdns_info_result_service_name
      .tr();
  final String _trailingLoc = LocaleKeys
      .views_lan_scan_mdns_info_result_service_type
      .tr();

  @override
  String? get subtitle =>
      mdnsModel.addresses?.map((e) => e.toString()).join('\n');

  @override
  String? get title => '$_titleLoc${mdnsModel.name ?? 'N/A'}';

  @override
  String? get trailing => '$_trailingLoc${mdnsModel.type}';
}
