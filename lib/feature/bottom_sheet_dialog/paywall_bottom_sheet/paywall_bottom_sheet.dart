import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:spy_scanner/core/app_sizes.dart';
import 'package:spy_scanner/core/extension/context_theme.dart';
import 'package:spy_scanner/feature/init/dependency_instances.dart';
import 'package:spy_scanner/feature/localization/localization_codegen/locale_keys.g.dart';
import 'package:spy_scanner/feature/services/payment_service.dart';
import 'package:spy_scanner/feature/utils/helper/price_formatter.dart';
import 'package:spy_scanner/feature/utils/ui/mutli_text_line.dart';

part 'widgets/action_bar.dart';
part 'widgets/feature_list.dart';
part 'widgets/offer_button.dart';
part 'widgets/offer_button_list.dart';

class PaywallBottomSheet extends StatelessWidget {
  const PaywallBottomSheet({
    required this.onLifetimePressed,
    required this.onMonthlyPressed,
    super.key,
  });

  final ValueChanged<Map<String, dynamic>?> onLifetimePressed;
  final ValueChanged<Map<String, dynamic>?> onMonthlyPressed;

  static Future<void> show(
    BuildContext context, {
    required ValueChanged<Map<String, dynamic>?> onLifetimePressed,
    required ValueChanged<Map<String, dynamic>?> onMonthlyPressed,
  }) => showCupertinoSheet<void>(
    context: context,
    builder: (context) => PaywallBottomSheet(
      onLifetimePressed: onLifetimePressed,
      onMonthlyPressed: onMonthlyPressed,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ColoredBox(
        color: context.colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            spacing: AppSizes.extraLarge * 2,
            children: [
              const _ActionBar(),
              const _FeatureList(),
              _OfferButtonList(
                onMonthlyPressed: onMonthlyPressed,
                onLifetimePressed: onLifetimePressed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
