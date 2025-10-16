// ignore_for_file: public_member_api_docs
import 'package:spy_scanner/feature/models/base_model.dart';

final class MdnsServiceModel extends BaseModel {
  const MdnsServiceModel({
    required super.id,
    this.name,
    this.type,
    this.port,
    this.addresses,
  });
  final String? name;
  final String? type;
  final int? port;
  final List<String>? addresses;

  @override
  List<Object?> get props => [...super.props, name, type, port, addresses];

  MdnsServiceModel copyWith({
    String? name,
    String? type,
    int? port,
    List<String>? addresses,
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
