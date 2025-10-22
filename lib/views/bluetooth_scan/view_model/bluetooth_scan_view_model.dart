// ignore_for_file: discarded_futures, document_ignores

part of '../bluetooth_scan_view.dart';

final class _BluetoothScanViewModel
    extends Bloc<_BluetoothScanEvent, _BluetoothScanState> {
  _BluetoothScanViewModel({
    required BleScannerManager bleScanner,
    required BluetoothStatusMonitor bleStatusMonitor,
  }) : _bleScanner = bleScanner,
       _bleStatusMonitor = bleStatusMonitor,
       super(const _IdleBluetoothScanState(items: [])) {
    var bleStatus = BleStatus.unknown;
    _bleStatusSubscription = _bleStatusMonitor.statusStream.listen((status) {
      bleStatus = status;
    });
    on<_BluetoothScanEventStartScan>(
      (event, emit) => _startScan(event, emit, bleStatus),
    );
    on<_BluetoothScanEventStopScan>(
      _stopScan,
    );
  }
  final BleScannerManager _bleScanner;
  final BluetoothStatusMonitor _bleStatusMonitor;
  StreamSubscription<BleStatus>? _bleStatusSubscription;

  FutureOr<void> _startScan(
    _BluetoothScanEventStartScan event,
    Emitter<_BluetoothScanState> emit,
    BleStatus currentStatus,
  ) async {
    await _bleScanner.startScan(currentStatus: currentStatus);
    await emit.onEach(
      _bleScanner.scannedDevicesStream,
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
    await _bleScanner.stopScan();
    emit(_IdleBluetoothScanState(items: state.items));
  }

  @override
  Future<void> close() {
    _bleStatusSubscription?.cancel();
    return super.close();
  }
}
