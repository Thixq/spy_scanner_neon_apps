part of '../home_view.dart';

class _Scanners extends StatelessWidget {
  _Scanners({
    required this.onWifiScanPressed,
    required this.onBluetoothScanPressed,
    required this.onInfraredScanPressed,
  });

  final VoidCallback onWifiScanPressed;
  final VoidCallback onBluetoothScanPressed;
  final VoidCallback onInfraredScanPressed;

  final String scanButtonText = 'LAN Scan';

  final _scanners = [
    ScanCardModel(
      contentTitle: 'LAN Scanner',
      contentSubTitle:
          'Scan all devices on the LAN and check which services are open.',
      icon: Icons.wifi_find,
    ),
    ScanCardModel(contentTitle: 'Bluetooth Scanner', icon: Icons.bluetooth),
    ScanCardModel(
      contentTitle: 'Infrared Detector',
      icon: CupertinoIcons.camera_viewfinder,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSizes.medium,
        children: [
          Flexible(
            child: ScanCard(
              scanner: _scanners[0],
              onButtonPressed: onWifiScanPressed,
              buttonText: scanButtonText,
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSizes.medium,
              children: [
                Flexible(
                  child: ScanCard(
                    scanner: _scanners[1],
                    isDisabled: true,
                    onCardPressed: onBluetoothScanPressed,
                  ),
                ),
                Flexible(
                  child: Banner(
                    message: 'Premium',
                    location: BannerLocation.topEnd,
                    child: ScanCard(
                      scanner: _scanners[2],
                      onCardPressed: onInfraredScanPressed,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
