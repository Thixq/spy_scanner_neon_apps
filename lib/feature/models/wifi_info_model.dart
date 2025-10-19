import 'package:connectivity_plus/connectivity_plus.dart';

class WifiInfo {
  WifiInfo({
    required this.status,
    this.wifiName,
    this.localIp,
  });
  final String? wifiName;
  final String? localIp;
  final ConnectivityResult status;

  @override
  String toString() {
    return 'Status: $status, Name: $wifiName, IP: $localIp';
  }
}
