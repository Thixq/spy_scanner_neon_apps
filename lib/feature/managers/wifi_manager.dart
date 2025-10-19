import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:spy_scanner/core/logging/custom_logger.dart';
import 'package:spy_scanner/core/logging/error_handler.dart';
import 'package:spy_scanner/feature/models/wifi_info_model.dart';

class WifiStatusMonitor {
  WifiStatusMonitor({
    required Connectivity connectivity,
    required NetworkInfo networkInfo,
  }) : _connectivity = connectivity,
       _networkInfo = networkInfo {
    _logger.info('$_moduleName initialized.');
  }
  static const String _moduleName = 'WifiStatusMonitor';

  final ErrorHandler _errorHandler = ErrorHandler(_moduleName);
  final CustomLogger _logger = CustomLogger(_moduleName);

  final Connectivity _connectivity;
  final NetworkInfo _networkInfo;

  /// Provides a stream of the current WiFi connection status (true if connected).
  Stream<bool> get onWifiStatusChanged {
    // Error handling in stream methods is usually done differently,
    // but we can use it directly in this simple map/distinct operation.
    return _connectivity.onConnectivityChanged.map((
      List<ConnectivityResult> results,
    ) {
      _logger.debug('Connectivity status changed. New results: $results');
      return results.contains(ConnectivityResult.wifi);
    }).distinct();
  }

  /// Retrieves the current WiFi information (SSID and Local IP).
  /// Uses ErrorHandler to safely execute native calls.
  Future<WifiInfo> getCurrentWifiInfo() async {
    // 1. Check the general connectivity status
    final connectivityResults = await _connectivity.checkConnectivity();

    if (connectivityResults.contains(ConnectivityResult.wifi)) {
      _logger.info('WiFi connection detected. Retrieving details.');

      // 2. Safely retrieve detailed WiFi information
      final result = await _errorHandler.executeSafely<Map<String, String?>>(
        () async {
          final wifiName = await _networkInfo.getWifiName();
          final localIp = await _networkInfo.getWifiIP();
          return {'wifiName': wifiName, 'localIp': localIp};
        },
        errorMessage:
            'Error while getting WiFi Name/IP address. (Permissions should be checked)',
        onError: (error, stackTrace) async {
          // Additional action if needed upon error, e.g., notifying the user.
          _logger.warning('Error caught, returning default value.');
        },
      );

      // 3. Process the retrieved result
      if (result != null) {
        final wifiName = result['wifiName'];
        final localIp = result['localIp'];

        // Logic to strip quotes on Android
        final cleanWifiName =
            (wifiName?.startsWith('"') ?? false) &&
                (wifiName?.endsWith('"') ?? false)
            ? wifiName!.substring(1, wifiName.length - 1)
            : wifiName;

        _logger.debug('WiFi Name: $cleanWifiName, Local IP: $localIp');

        return WifiInfo(
          status: ConnectivityResult.wifi,
          wifiName: cleanWifiName,
          localIp: localIp,
        );
      } else {
        // If executeSafely returned null (meaning an error occurred and was logged)
        return WifiInfo(
          status: ConnectivityResult.wifi,
          wifiName: 'Error/Missing Permissions', // Default error message
        );
      }
    } else if (connectivityResults.contains(ConnectivityResult.none)) {
      _logger.info('No network connection (None).');
      return WifiInfo(status: ConnectivityResult.none);
    } else {
      _logger.info('Connected to a different network type (Mobile/Ethernet).');
      return WifiInfo(status: ConnectivityResult.other);
    }
  }
}
