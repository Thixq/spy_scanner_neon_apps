part of '../lan_scan_view.dart';

sealed class _ScanState extends Equatable {
  const _ScanState({required this.items});

  final List<_ScanResultModel> items;

  @override
  List<Object?> get props => [items];
}

final class _IdleScanState extends _ScanState {
  const _IdleScanState({required super.items});
}

final class _ScanningScanState extends _ScanState {
  const _ScanningScanState({
    required super.items,
    required this.scanType,
  });
  final _ScanType scanType;
}

final class _ScanErrorScanState extends _ScanState {
  const _ScanErrorScanState(this.message, {required super.items});

  final String message;

  @override
  List<Object?> get props => [...super.props, message];
}
