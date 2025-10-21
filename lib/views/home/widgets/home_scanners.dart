// ignore_for_file: unused_element_parameter, document_ignores

part of '../home_view.dart';

final String _commoingSoon = LocaleKeys.generic_comming_soon.tr();
final String _premium = LocaleKeys.generic_premium_text.tr();

class _Scanners extends StatelessWidget {
  const _Scanners({
    required this.onWifiScanPressed,
    required this.onBluetoothScanPressed,
    required this.onInfraredScanPressed,
    required this.scanners,
    required this.onPremiumActionPressed,
    this.isPremium = false,
    this.isBluetoothDisabled = true,
    this.isInfraredDisabled = true,
    this.isWifiDisabled = true,
  });

  final VoidCallback onWifiScanPressed;
  final VoidCallback onBluetoothScanPressed;
  final VoidCallback onInfraredScanPressed;
  final VoidCallback onPremiumActionPressed;
  final bool isPremium;
  final List<ScanCardModel> scanners;
  final bool isWifiDisabled;
  final bool isBluetoothDisabled;
  final bool isInfraredDisabled;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 5,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSizes.medium,
        children: [
          Flexible(
            child: ScanCard(
              scanner: scanners[0],
              isDisabled: isWifiDisabled,
              onButtonPressed: onWifiScanPressed,
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSizes.medium,
              children: [
                Flexible(
                  child: ClipRRect(
                    child: isPremium
                        ? ScanCard(
                            scanner: scanners[1],
                            isDisabled: isBluetoothDisabled,
                            onCardPressed:
                                onBluetoothScanPressed, // Premium kullanıcı doğrudan erişsin
                          )
                        : Banner(
                            message: _premium,
                            location: BannerLocation.topEnd,
                            child: ScanCard(
                              scanner: scanners[1],
                              onCardPressed:
                                  onPremiumActionPressed, // Premium olmayan kullanıcı tıklayınca yönlendirilir
                            ),
                          ),
                  ),
                ),
                Flexible(
                  child: ClipRRect(
                    child: Banner(
                      message: _commoingSoon,
                      location: BannerLocation.topEnd,
                      child: ScanCard(
                        scanner: scanners[2],
                        isDisabled: isInfraredDisabled,
                        onCardPressed: onInfraredScanPressed,
                      ),
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
