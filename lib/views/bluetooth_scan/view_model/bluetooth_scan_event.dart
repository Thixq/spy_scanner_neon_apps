part of '../bluetooth_scan_view.dart';

sealed class _BluetoothScanEvent {}

final class _BluetoothScanEventStartScan extends _BluetoothScanEvent {}

final class _BluetoothScanEventStopScan extends _BluetoothScanEvent {}
