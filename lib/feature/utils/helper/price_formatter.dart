import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PriceFormatter {
  static String format(
    double value,
    BuildContext context, {
    String? currencyCode,
  }) {
    final locale = context.locale.toString();

    // Determine currency code from locale (fallback: USD)
    final code = currencyCode ?? _localeToCurrency(locale);

    // Create a currency format
    final format = NumberFormat.currency(
      locale: locale,
      name: code,
      symbol: '',
    );

    final formattedValue = format.format(value);

    // Get locale-specific currency symbol
    final currencySymbol = NumberFormat.compactSimpleCurrency(
      locale: locale,
      name: code,
    ).currencySymbol;

    // Some languages place the symbol after the value
    if (_symbolAfter(locale)) {
      return '$formattedValue $currencySymbol';
    } else {
      return '$currencySymbol$formattedValue';
    }
  }

  static String localizedPriceText(
    double value,
    BuildContext context, {
    String? currencyCode,
  }) {
    final formatted = format(value, context, currencyCode: currencyCode);
    return tr('subscription.price_text', args: [formatted]);
  }

  // Locale → Currency mapping
  static String _localeToCurrency(String locale) {
    final map = {
      'tr': 'TRY',
      'en_US': 'USD',
    };

    // if no exact match, check only the language part
    return map[locale] ?? map[locale.split('_').first] ?? 'USD';
  }

  // Symbol position (before/after)
  static bool _symbolAfter(String locale) {
    final langsWithAfterSymbol = [
      'tr',
      'de',
      'fr',
      'ru',
      'sv',
      'pl',
      'es',
      'it',
    ];
    return langsWithAfterSymbol.any(locale.startsWith);
  }
}
