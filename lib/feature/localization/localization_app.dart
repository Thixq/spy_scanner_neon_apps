import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart' show BuildContext, Locale;
import 'package:spy_scanner/feature/localization/localization_codegen/codegen_loader.g.dart';

class LocalizationApp extends EasyLocalization {
  LocalizationApp({
    required super.child,
    super.key,
  }) : super(
         saveLocale: true,
         useOnlyLangCode: true,
         supportedLocales: supportedLocalesLanguages,
         path: _translationPath,
         assetLoader: const CodegenLoader(),
       );

  static const String _translationPath = 'assets/translations';

  @override
  Locale? get fallbackLocale => const Locale('tr', 'TR');

  static List<Locale> get supportedLocalesLanguages => [
    const Locale('tr'),
    const Locale('en'),
  ];

  static Future<void> updateLanguage({
    required BuildContext context,
    required Locale value,
  }) => context.setLocale(value);

  /// Method to reset the language.
  static Future<void> setLocaleLanguage({
    required BuildContext context,
  }) => context.resetLocale();
}
