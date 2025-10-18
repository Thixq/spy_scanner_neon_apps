import 'package:spy_scanner/feature/models/base_model.dart';

class BluetoothDeviceModel extends BaseModel {
  const BluetoothDeviceModel({required super.id, this.name, this.rssi});
  final String? name;
  final int? rssi;

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
