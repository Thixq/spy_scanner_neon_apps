part of 'onboard_view.dart';

mixin _OnboardMixin on State<OnboardView> {
  late final PageController _pageController;
  bool isLastPage = false;
  int currentPage = 0;

  final _pages = <_OnboardingPageModel>[
    _OnboardingPageModel(
      title: LocaleKeys.views_onboard_page_one_title.tr(),
      description: LocaleKeys.views_onboard_page_one_description.tr(),
      lottiePath: LottieAssets.wifiEye,
    ),
    _OnboardingPageModel(
      title: LocaleKeys.views_onboard_page_two_title.tr(),
      description: LocaleKeys.views_onboard_page_two_description.tr(),
      lottiePath: LottieAssets.bluetoothRadial,
    ),
    _OnboardingPageModel(
      title: LocaleKeys.views_onboard_page_three_title.tr(),
      description: LocaleKeys.views_onboard_page_three_description.tr(),
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
