part of 'onboard_view.dart';

mixin _OnboardMixin on State<OnboardView> {
  late final PageController _pageController;
  bool isLastPage = false;
  int currentPage = 0;

  final _pages = <_OnboardingPageModel>[
    const _OnboardingPageModel(
      title: 'LAN Scanner',
      description:
          'It can detect the devices connected to your network. If there are more devices connected than you expect, you may suspect something.',
      lottiePath: LottieAssets.wifiEye,
    ),
    const _OnboardingPageModel(
      title: 'Bluetooth Scanner',
      description:
          'You can track all devices emitting BLE signals and their distance from you. If you receive a signal that is very close to you but does not belong to you, you may suspect something.',
      lottiePath: LottieAssets.bluetoothRadial,
    ),
    const _OnboardingPageModel(
      title: 'Infrared Scanner',
      description:
          'You can detect infrared sensors and their derivatives hidden in sockets and shower heads using different camera filters.',
      lottiePath: LottieAssets.brotherEye,
    ),
  ];

  @override
  void initState() {
    _pageController = PageController();
    _pageController.addListener(_pageListener);
    super.initState();
  }

  void _pageListener() {
    final page = _pageController.page?.round() ?? 0;
    if (page != currentPage) {
      setState(() => currentPage = page);
      isLastPage = currentPage == _pages.length - 1;
    }
  }

  @override
  void dispose() {
    _pageController
      ..removeListener(_pageListener)
      ..dispose();
    super.dispose();
  }

  Future<void> _onNext() async {
    if (isLastPage) {
      await context.router.replace(const HomeRoute());
    } else {
      await _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _onPrevious() async {
    if (currentPage > 0) {
      await _pageController.previousPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }
}
