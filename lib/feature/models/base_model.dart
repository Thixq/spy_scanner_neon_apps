import 'package:equatable/equatable.dart';

abstract class BaseModel extends Equatable {
  const BaseModel({required this.id});
  final String id;

  @override
  List<Object?> get props => [id];
}
