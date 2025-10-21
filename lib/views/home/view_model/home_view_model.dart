// ignore_for_file: discarded_futures, document_ignores

part of '../home_view.dart';

final class _HomeViewModel extends Cubit<_HomeState> {
  _HomeViewModel({
    required BluetoothStatusMonitor bluetoothStatusMonitor,
    required WifiStatusMonitor wifiStatusMonitor,
    required AccountManager accountManager,
  }) : _bluetoothStatusMonitor = bluetoothStatusMonitor,
       _wifiStatusMonitor = wifiStatusMonitor,
       _accountManager = accountManager,
       super(
         const _HomeState(
           wifiState: _WifiDisabled(),
           bluetoothState: _BluetoothDisabled(),
         ),
       );
  final BluetoothStatusMonitor _bluetoothStatusMonitor;
  final WifiStatusMonitor _wifiStatusMonitor;
  final AccountManager _accountManager;
  late final StreamSubscription<BleStatus>? _bleStatusSubscription;
  late final StreamSubscription<bool>? _wifiStatusSubscription;
  late final StreamSubscription<bool>? _premiumSubscription;

  void init() {
    _startListeningPremium();
    _startListeningWifi();
    _startListeningBluetooth();
  }

  Future<void> addPremium() async {
    await _accountManager.addPremium();
  }

  void _startListeningPremium() {
    if (_accountManager.isPremiumSnapshot) {}
    _premiumSubscription = _accountManager.isPremiumStream.listen(
      (isPremium) {
        emit(state.copyWith(isPremiumActive: isPremium));
      },
    );
  }

  void _startListeningWifi() {
    _wifiStatusSubscription = _wifiStatusMonitor.onWifiStatusChanged.listen(
      (status) async {
        if (status) {
          final wifiInfo = await _wifiStatusMonitor.getCurrentWifiInfo();
          emit(
            state.copyWith(wifiState: _WifiEnabled(wifiInfo: wifiInfo)),
          );
        } else {
          emit(state.copyWith(wifiState: const _WifiDisabled()));
        }
      },
    );
  }

  void _startListeningBluetooth() {
    _bleStatusSubscription = _bluetoothStatusMonitor.statusStream.listen(
      (status) {
        if (status == BleStatus.ready) {
          emit(state.copyWith(bluetoothState: const _BluetoothEnabled()));
        } else {
          emit(state.copyWith(bluetoothState: const _BluetoothDisabled()));
        }
      },
    );
  }

  @override
  Future<void> close() {
    _bleStatusSubscription?.cancel();
    _wifiStatusSubscription?.cancel();
    _premiumSubscription?.cancel();
    return super.close();
  }
}
