import 'package:spy_scanner/feature/models/base_model.dart';

class HostModel extends BaseModel {
  const HostModel({
    required super.id,
    this.address,
    this.deviceName,
    this.mac,
    this.vendor,
  });
  final String? address;
  final String? deviceName;
  final String? mac;
  final String? vendor;

  @override
  List<Object?> get props => [...super.props, address, deviceName, mac, vendor];

  HostModel copyWith({
    String? address,
    String? deviceName,
    String? mac,
    String? vendor,
  }) {
    return HostModel(
      id: id,
      address: address ?? this.address,
      deviceName: deviceName ?? this.deviceName,
      mac: mac ?? this.mac,
      vendor: vendor ?? this.vendor,
    );
  }
}
