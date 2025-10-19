part of '../bluetooth_scan_view.dart';

final class _BluetoothScanViewModel
    extends Bloc<_BluetoothScanEvent, _BluetoothScanState> {
  _BluetoothScanViewModel({required BleScannerManager bleManager})
    : _bleManager = bleManager,
      super(const _IdleBluetoothScanState(items: [])) {
    on<_BluetoothScanEventStartScan>(
      _startScan,
    );
    on<_BluetoothScanEventStopScan>(
      _stopScan,
    );
  }
  final BleScannerManager _bleManager;

  FutureOr<void> _startScan(
    _BluetoothScanEventStartScan event,
    Emitter<_BluetoothScanState> emit,
  ) async {
    await _bleManager.startScan();
    await emit.onEach(
      _bleManager.scannedDevicesStream,
      onData: (devices) {
        final items = devices
            .map(
              (e) => _DeviceResultModel(
                title: e.name,
                subtitle: e.id,
                trailing: e.rssi.toString(),
              ),
            )
            .toList();
        emit(_ScanningBluetoothScanState(items: items));
      },
    );
  }

  FutureOr<void> _stopScan(
    _BluetoothScanEventStopScan event,
    Emitter<_BluetoothScanState> emit,
  ) async {
    await _bleManager.stopScan();
    emit(_IdleBluetoothScanState(items: state.items));
  }

  @override
  Future<void> close() {
    _bleManager.dispose();
    return super.close();
  }
}
