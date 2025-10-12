import 'package:auto_route/auto_route.dart';

import 'package:spy_scanner/feature/routing/app_routing.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View,Route')
final class AppRouting extends RootStackRouter {
  static AppRouting? _instance;
  static AppRouting get instance => _instance ??= AppRouting();

  @override
  RouteType get defaultRouteType => const RouteType.adaptive();
  @override
  List<AutoRoute> get routes => [
    AutoRoute(initial: true, page: OnboardRoute.page),
  ];
}
