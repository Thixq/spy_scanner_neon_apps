part of 'bluetooth_scan_view.dart';

sealed class _DeviceResultModel extends Equatable {
  String? get title;
  String? get subtitle;
  String? get trailing;

  @override
  List<Object?> get props => [title, subtitle, trailing];
}
