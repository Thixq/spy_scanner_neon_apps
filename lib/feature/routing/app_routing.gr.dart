// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:spy_scanner/dev/dev_nsd_view.dart' as _i5;
import 'package:spy_scanner/views/bluetooth_scan/bluetooth_scan_view.dart'
    as _i1;
import 'package:spy_scanner/views/home/home_view.dart' as _i2;
import 'package:spy_scanner/views/lan_scan/lan_scan_view.dart' as _i3;
import 'package:spy_scanner/views/onboard/onboard_view.dart' as _i4;
import 'package:spy_scanner/views/settings/settings_view.dart' as _i6;
import 'package:spy_scanner/views/splash/splash_view.dart' as _i7;

/// generated route for
/// [_i1.BluetoothScanView]
class BluetoothScanRoute extends _i8.PageRouteInfo<void> {
  const BluetoothScanRoute({List<_i8.PageRouteInfo>? children})
    : super(BluetoothScanRoute.name, initialChildren: children);

  static const String name = 'BluetoothScanRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i1.BluetoothScanView();
    },
  );
}

/// generated route for
/// [_i2.HomeView]
class HomeRoute extends _i8.PageRouteInfo<void> {
  const HomeRoute({List<_i8.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomeView();
    },
  );
}

/// generated route for
/// [_i3.LanScanView]
class LanScanRoute extends _i8.PageRouteInfo<void> {
  const LanScanRoute({List<_i8.PageRouteInfo>? children})
    : super(LanScanRoute.name, initialChildren: children);

  static const String name = 'LanScanRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i3.LanScanView();
    },
  );
}

/// generated route for
/// [_i4.OnboardView]
class OnboardRoute extends _i8.PageRouteInfo<void> {
  const OnboardRoute({List<_i8.PageRouteInfo>? children})
    : super(OnboardRoute.name, initialChildren: children);

  static const String name = 'OnboardRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i4.OnboardView();
    },
  );
}

/// generated route for
/// [_i5.ServiceDiscoveryView]
class ServiceDiscoveryRoute extends _i8.PageRouteInfo<void> {
  const ServiceDiscoveryRoute({List<_i8.PageRouteInfo>? children})
    : super(ServiceDiscoveryRoute.name, initialChildren: children);

  static const String name = 'ServiceDiscoveryRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i5.ServiceDiscoveryView();
    },
  );
}

/// generated route for
/// [_i6.SettingsView]
class SettingsRoute extends _i8.PageRouteInfo<void> {
  const SettingsRoute({List<_i8.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i6.SettingsView();
    },
  );
}

/// generated route for
/// [_i7.SplashView]
class SplashRoute extends _i8.PageRouteInfo<void> {
  const SplashRoute({List<_i8.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i7.SplashView();
    },
  );
}
