// ignore_for_file: discarded_futures, document_ignores

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spy_scanner/feature/managers/host_scanner_manager.dart';
import 'package:spy_scanner/views/lan_scan/view_model/scan_event.dart';
import 'package:spy_scanner/views/lan_scan/view_model/scan_state.dart';

final class LanScanViewModel extends Bloc<ScanlEvent, ScanState> {
  LanScanViewModel({required HostScanManager hostScanManager})
    : _hostScanManager = hostScanManager,
      super(const IdleScanState(items: [])) {
    on<ScanEventStartScan>(_startScan);
    on<ScanEventStopScan>(_stopScan);
  }

  final HostScanManager _hostScanManager;

  Future<void> _startScan(
    ScanEventStartScan event,
    Emitter<ScanState> emit,
  ) async {
    emit(IdleScanState(items: [...state.items]));
    await _hostScanManager.startScan(event.subnet);

    await emit.onEach(
      _hostScanManager.hostsStream,
      onData: (hosts) => ScanningScanState(items: List.of(hosts)),
    );
  }

  Future<void> _stopScan(
    ScanEventStopScan event,
    Emitter<ScanState> emit,
  ) async {
    emit(IdleScanState(items: state.items));
    await _hostScanManager.stopScan();
  }

  void dispose() {
    _hostScanManager.dispose();
    super.close();
  }
}
