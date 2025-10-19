part of '../home_view.dart';

final class _HomeState extends Equatable {
  const _HomeState({required this.wifiState, required this.bluetoothState});
  final _WifiState? wifiState;
  final _BluetoothState? bluetoothState;
  @override
  List<Object?> get props => [wifiState, bluetoothState];

  _HomeState copyWith({
    _WifiState? wifiState,
    _BluetoothState? bluetoothState,
  }) {
    return _HomeState(
      wifiState: wifiState ?? this.wifiState,
      bluetoothState: bluetoothState ?? this.bluetoothState,
    );
  }
}

sealed class _WifiState extends Equatable {
  const _WifiState();
  @override
  List<Object?> get props => [];
}

final class _WifiEnabled extends _WifiState {
  const _WifiEnabled({required this.wifiInfo});
  final WifiInfo wifiInfo;

  @override
  List<Object?> get props => [...super.props, wifiInfo];
}

final class _WifiDisabled extends _WifiState {
  const _WifiDisabled();
}

sealed class _BluetoothState extends Equatable {
  const _BluetoothState();
  @override
  List<Object?> get props => [];
}

final class _BluetoothEnabled extends _BluetoothState {
  const _BluetoothEnabled();
}

final class _BluetoothDisabled extends _BluetoothState {
  const _BluetoothDisabled();
}
