import 'package:spy_scanner/feature/models/base_model.dart';

final class MdnsServiceModel extends BaseModel {
  const MdnsServiceModel({
    required super.id,
    this.name = 'N/A',
    this.type = 'N/A',
    this.port,
    this.addresses,
  });
  final String? name;
  final String? type;
  final int? port;
  final List<MdnsIpAddress>? addresses;

  @override
  List<Object?> get props => [...super.props, name, type, port, addresses];

  MdnsServiceModel copyWith({
    String? name,
    String? type,
    int? port,
    List<MdnsIpAddress>? addresses,
  }) {
    return MdnsServiceModel(
      id: id,
      name: name ?? this.name,
      type: type ?? this.type,
      port: port ?? this.port,
      addresses: addresses ?? this.addresses,
    );
  }
}

final class MdnsIpAddress {
  MdnsIpAddress({this.address, this.type});

  final String? address;
  final String? type;

  @override
  String toString() {
    return '$type: $address';
  }
}
