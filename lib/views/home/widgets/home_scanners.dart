part of '../home_view.dart';

class _Scanners extends StatelessWidget {
  const _Scanners({
    required this.onWifiScanPressed,
    required this.onBluetoothScanPressed,
    required this.onInfraredScanPressed,
    required this.scanners,
  });

  final VoidCallback onWifiScanPressed;
  final VoidCallback onBluetoothScanPressed;
  final VoidCallback onInfraredScanPressed;
  final List<ScanCardModel> scanners;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSizes.medium,
        children: [
          Flexible(
            child: ScanCard(
              scanner: scanners[0],
              onButtonPressed: onWifiScanPressed,
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSizes.medium,
              children: [
                Flexible(
                  child: ScanCard(
                    scanner: scanners[1],
                    onCardPressed: onBluetoothScanPressed,
                  ),
                ),
                Flexible(
                  child: Banner(
                    message: 'Premium',
                    location: BannerLocation.topEnd,
                    child: ScanCard(
                      scanner: scanners[2],
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
