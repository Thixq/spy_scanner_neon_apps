import 'package:equatable/equatable.dart';

sealed class ScanlEvent extends Equatable {
  const ScanlEvent();
  @override
  List<Object> get props => [];
}

class ScanEventStartScan extends ScanlEvent {
  const ScanEventStartScan({required this.subnet});

  final String subnet;
}

class ScanEventStopScan extends ScanlEvent {}
