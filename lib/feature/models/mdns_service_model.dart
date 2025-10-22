import 'package:json_annotation/json_annotation.dart';
import 'package:spy_scanner/feature/models/base_model.dart';

part 'mdns_service_model.g.dart';

@JsonSerializable(checked: true, explicitToJson: true)
final class MdnsServiceModel extends BaseModel {
  const MdnsServiceModel({
    required super.id,
    this.name,
    this.type,
    this.port,
    this.addresses,
  });

  factory MdnsServiceModel.fromJson(Map<String, dynamic> json) =>
      _$MdnsServiceModelFromJson(json);
  final String? name;
  final String? type;
  final int? port;
  final List<MdnsIpAddress>? addresses;

  @override
  MdnsServiceModel fromJson(Map<String, dynamic> json) =>
      _$MdnsServiceModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MdnsServiceModelToJson(this);

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

@JsonSerializable(checked: true)
final class MdnsIpAddress extends BaseModel {
  const MdnsIpAddress({required super.id, this.address, this.type});

  factory MdnsIpAddress.fromJson(Map<String, dynamic> json) =>
      _$MdnsIpAddressFromJson(json);

  final String? address;
  final String? type;

  @override
  MdnsIpAddress fromJson(Map<String, dynamic> json) =>
      _$MdnsIpAddressFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MdnsIpAddressToJson(this);

  @override
  List<Object?> get props => [...super.props, address, type];

  @override
  String toString() {
    return '$type: $address';
  }
}
