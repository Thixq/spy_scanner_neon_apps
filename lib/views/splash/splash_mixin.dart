part of 'splash_view.dart';

mixin _SplashMixin on State<SplashView> {
  Future<void> _isfirstLaunch() async {
    final isFirstLaunch = DependencyInstances.service.sharedPreferences.getBool(
      'isFirstLaunch',
    );
    if (isFirstLaunch == null || !isFirstLaunch) {
      await context.router.replace(const OnboardRoute());
    } else if (isFirstLaunch) {
      await context.router.replace(const HomeRoute());
    }
  }

  @override
  void initState() {
    _isfirstLaunch();
    super.initState();
  }
}
