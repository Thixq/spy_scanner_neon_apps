// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:spy_scanner/views/home/home_view.dart' as _i1;
import 'package:spy_scanner/views/onboard/onboard_view.dart' as _i2;

/// generated route for
/// [_i1.HomeView]
class HomeRoute extends _i3.PageRouteInfo<void> {
  const HomeRoute({List<_i3.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i1.HomeView();
    },
  );
}

/// generated route for
/// [_i2.OnboardView]
class OnboardRoute extends _i3.PageRouteInfo<void> {
  const OnboardRoute({List<_i3.PageRouteInfo>? children})
    : super(OnboardRoute.name, initialChildren: children);

  static const String name = 'OnboardRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i2.OnboardView();
    },
  );
}
