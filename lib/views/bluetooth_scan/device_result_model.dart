part of 'bluetooth_scan_view.dart';

final String _title = LocaleKeys.views_bluetooth_scan_bluetooth_info_result_name
    .tr();
final String _subtitle = LocaleKeys
    .views_bluetooth_scan_bluetooth_info_result_address
    .tr();
String _trailing(String? rssi) => LocaleKeys
    .views_bluetooth_scan_bluetooth_info_result_rssi
    .tr(namedArgs: {'rssi': rssi ?? '-'});

final class _DeviceResultModel extends Equatable {
  _DeviceResultModel({
    String? title,
    String? subtitle,
    String? trailing,
  }) : subtitle = '$_subtitle$subtitle',
       title = '$_title$title',
       trailing = '${_trailing(trailing)} ';
  final String? title;
  final String? subtitle;
  final String? trailing;

  @override
  List<Object?> get props => [title, subtitle, trailing];
}
