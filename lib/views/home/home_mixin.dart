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

  late final _HomeViewModel _viewModel;

  void _goSettings() {
    context.router.push(const SettingsRoute());
  }

  void _goLanScanView() {
    context.router.push(const LanScanRoute());
  }

  void _goBluetoothScanView() {
    context.router.push(const BluetoothScanRoute());
  }

  Future<void> _paywall() async {
    await PaywallBottomSheet.show(
      context,
      onMonthlyPressed: (payResult) async {
        await _viewModel.addPremium();
        context.router.pop();
      },
      onLifetimePressed: (payResult) async {
        await _viewModel.addPremium();
        context.router.pop();
      },
    );
  }

  void _onFeedBack() {
    FeedbackDialog.show(context);
  }

  @override
  void initState() {
    _viewModel = _HomeViewModel(
      bluetoothStatusMonitor: DependencyInstances.monitoring.bluetooth,
      wifiStatusMonitor: DependencyInstances.monitoring.wifi,
      accountManager: DependencyInstances.manager.account,
    );
    _viewModel.init();
    super.initState();
  }
}
