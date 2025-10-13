import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spy_scanner/core/app_sizes.dart';
import 'package:spy_scanner/core/extension/context_theme.dart';
import 'package:spy_scanner/feature/localization/localization_codegen/locale_keys.g.dart';

final String _title = LocaleKeys.privacy_policy_title.tr();
final String _text = LocaleKeys.privacy_policy_text.tr();

class TextBottomSheet extends StatelessWidget {
  const TextBottomSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const TextBottomSheet(),
      showDragHandle: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      builder: (context, scrollController) => SingleChildScrollView(
        controller: scrollController,
        child: Padding(
          padding: const EdgeInsets.only(
            left: AppSizes.large,
            right: AppSizes.large,
            bottom: AppSizes.extraLarge,
          ),
          child: RichText(
            text: TextSpan(
              text: '$_title\n',
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: _text,
                  style: context.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
