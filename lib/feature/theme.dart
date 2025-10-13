import 'package:flutter/material.dart';
import 'package:spy_scanner/core/app_sizes.dart';

/// The theme for the app.
final class SpyTheme {
  const SpyTheme._();

  /// The seed color for the app.
  static const _seedColor = Color(0xFFDD0303);

  /// The filled button theme for the app.
  static FilledButtonThemeData get filledButtonTheme => FilledButtonThemeData(
    style: FilledButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: AppSizes.mediumBorderRadius),
    ),
  );

  /// The input decoration theme for the app.
  static InputDecorationTheme get inputDecorationTheme => InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: AppSizes.mediumBorderRadius),
  );

  /// The dark theme for the app.
  static ThemeData dark() => ThemeData.dark().copyWith(
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: _seedColor,
    ),
    filledButtonTheme: filledButtonTheme,
    inputDecorationTheme: inputDecorationTheme,
  );

  /// The light theme for the app.
  static ThemeData light() => ThemeData.light().copyWith(
    colorScheme: ColorScheme.fromSeed(seedColor: _seedColor),
    filledButtonTheme: filledButtonTheme,
    inputDecorationTheme: inputDecorationTheme,
  );
}
