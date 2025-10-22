import 'package:equatable/equatable.dart';

abstract class BaseModel extends Equatable {
  const BaseModel({required this.id});

  BaseModel fromJson(Map<String, dynamic> json) => throw UnimplementedError();

  Map<String, dynamic> toJson() => throw UnimplementedError();

  final String id;

  @override
  List<Object?> get props => [id];
}
