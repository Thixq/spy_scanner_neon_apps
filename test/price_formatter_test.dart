import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spy_scanner/feature/utils/helper/price_formatter.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  await EasyLocalization.ensureInitialized();

  group('PriceFormatter dynamic currency detection', () {
    testWidgets('Turkish locale uses TRY symbol', (tester) async {
      await tester.pumpWidget(
        EasyLocalization(
          supportedLocales: const [Locale('tr', 'TR')],
          path: 'assets/translations',
          fallbackLocale: const Locale('tr', 'TR'),
          child: Builder(
            builder: (context) {
              final result = PriceFormatter.format(99.99, context);
              expect(result.contains('TL'), true);
              return const SizedBox();
            },
          ),
        ),
      );
    });

    testWidgets('US locale uses dollar before value', (tester) async {
      await tester.pumpWidget(
        EasyLocalization(
          supportedLocales: const [Locale('en', 'US')],
          path: 'assets/translations',
          fallbackLocale: const Locale('en', 'US'),
          child: Builder(
            builder: (context) {
              final result = PriceFormatter.format(99.99, context);
              expect(result.startsWith(r'$'), true);
              return const SizedBox();
            },
          ),
        ),
      );
    });
  });
}
