part of '../bluetooth_scan_view.dart';

sealed class _BluetoothScanState {
  const _BluetoothScanState({
    required this.items,
  });
  final List<_DeviceResultModel> items;
}

final class _IdleBluetoothScanState extends _BluetoothScanState {
  const _IdleBluetoothScanState({
    required super.items,
  });
}

final class _ScanningBluetoothScanState extends _BluetoothScanState {
  const _ScanningBluetoothScanState({
    required super.items,
  });
}
