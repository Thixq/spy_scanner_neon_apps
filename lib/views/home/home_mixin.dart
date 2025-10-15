// ignore_for_file: discarded_futures, document_ignores

part of 'home_view.dart';

mixin _HomeMixin on State<HomeView> {
  final _scanners = [
    ScanCardModel(
      contentTitle: LocaleKeys.views_home_scanners_scanner_one_title.tr(),
      contentSubTitle: LocaleKeys.views_home_scanners_scanner_one_description
          .tr(),
      buttonText: LocaleKeys.views_home_scanners_scanner_one_button_text.tr(),
      icon: Icons.wifi_find,
    ),
    ScanCardModel(
      contentTitle: LocaleKeys.views_home_scanners_scanner_two_title.tr(),
      icon: Icons.bluetooth,
    ),
    ScanCardModel(
      contentTitle: LocaleKeys.views_home_scanners_scanner_three_title.tr(),
      icon: CupertinoIcons.camera_viewfinder,
    ),
  ];

  void _goLanScanView() {
    context.router.push(const LanScanRoute());
  }

  void _goNsdScanView() {
    context.router.push(const ServiceDiscoveryRoute());
  }

  Future<void> _paywall() async {
    await PaywallBottomSheet.show(
      context,
      onLifetimePressed: (payResult) {
        context.router.pop();
      },
      onMonthlyPressed: (payResult) {
        context.router.pop();
      },
    );
  }
}
