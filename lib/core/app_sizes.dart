import 'package:flutter/material.dart';

/// P roject constants
final class AppSizes {
  const AppSizes._();

  /// 2.0
  static const double extraSmall = 2;

  /// 4.0
  static const double xSmall = 4;

  /// 8.0
  static const double small = 8;

  /// 16.0
  static const double medium = 16;

  /// 24.0
  static const double large = 24;

  /// 32.0
  static const double extraLarge = 32;

  /// EdgeInsets: 4.0
  static EdgeInsets get xSmallPadding => const EdgeInsets.all(xSmall);

  /// EdgeInsets: 8.0
  static EdgeInsets get smallPadding => const EdgeInsets.all(small);

  /// EdgeInsets: 16.0
  static EdgeInsets get mediumPadding => const EdgeInsets.all(medium);

  /// EdgeInsets: 24.0
  static EdgeInsets get largePadding => const EdgeInsets.all(large);

  /// EdgeInsets: 32.0
  static EdgeInsets get extraLargePadding => const EdgeInsets.all(extraLarge);

  /// BorderRadius: 4.0
  static BorderRadius get xSmallBorderRadius =>
      const BorderRadius.all(Radius.circular(xSmall));

  /// BorderRadius: 8.0
  static BorderRadius get smallBorderRadius =>
      const BorderRadius.all(Radius.circular(small));

  /// BorderRadius: 16.0
  static BorderRadius get mediumBorderRadius =>
      const BorderRadius.all(Radius.circular(medium));

  /// BorderRadius: 24.0
  static BorderRadius get largeBorderRadius =>
      const BorderRadius.all(Radius.circular(large));

  /// BorderRadius: 32.0
  static BorderRadius get extraLargeBorderRadius =>
      const BorderRadius.all(Radius.circular(extraLarge));
}
