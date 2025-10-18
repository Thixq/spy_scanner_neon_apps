part of '../lan_scan_view.dart';

sealed class _ScanlEvent extends Equatable {
  const _ScanlEvent();
  @override
  List<Object> get props => [];
}

class _ScanEventStartScan extends _ScanlEvent {
  const _ScanEventStartScan({required this.scanType});

  final _ScanType scanType;
}

class _ScanEventStopScan extends _ScanlEvent {
  const _ScanEventStopScan({required this.scanType});

  final _ScanType scanType;
}
