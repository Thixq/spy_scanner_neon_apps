import 'package:equatable/equatable.dart';
import 'package:spy_scanner/feature/models/host_model.dart';

sealed class ScanState extends Equatable {
  const ScanState({required this.items});

  final List<HostModel> items;

  @override
  List<Object?> get props => [items];
}

final class IdleScanState extends ScanState {
  const IdleScanState({required super.items});
}

final class ScanningScanState extends ScanState {
  const ScanningScanState({required super.items});
}

final class ScanErrorScanState extends ScanState {
  const ScanErrorScanState(this.message, {required super.items});

  final String message;

  @override
  List<Object?> get props => [...super.props, message];
}
