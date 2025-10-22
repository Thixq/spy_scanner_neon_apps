import 'package:json_annotation/json_annotation.dart';
import 'package:spy_scanner/feature/models/base_model.dart';

part 'bluetooth_device_model.g.dart';

@JsonSerializable(checked: true)
class BluetoothDeviceModel extends BaseModel {
  const BluetoothDeviceModel({required super.id, this.name, this.rssi});
  final String? name;
  final int? rssi;

  @override
  BluetoothDeviceModel fromJson(Map<String, dynamic> json) =>
      _$BluetoothDeviceModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BluetoothDeviceModelToJson(this);

  BluetoothDeviceModel copyWith({
    String? name,
    int? rssi,
  }) {
    return BluetoothDeviceModel(
      id: id,
      name: name ?? this.name,
      rssi: rssi ?? this.rssi,
    );
  }
}
