import 'package:flutter/material.dart';
import 'package:spy_scanner/core/app_sizes.dart';

/// The theme for the app.
final class SpyTheme {
  const SpyTheme._();

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
  static ThemeData dark({required Color seedColor}) =>
      ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: seedColor,
        ),
        filledButtonTheme: filledButtonTheme,
        inputDecorationTheme: inputDecorationTheme,
      );

  /// The light theme for the app.
  static ThemeData light({required Color seedColor}) =>
      ThemeData.light().copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: seedColor),
        filledButtonTheme: filledButtonTheme,
        inputDecorationTheme: inputDecorationTheme,
      );
}
