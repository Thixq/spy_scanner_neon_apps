import 'package:flutter/material.dart';
import 'package:spy_scanner/core/app_sizes.dart';
import 'package:spy_scanner/core/extension/context_theme.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: context.colorScheme.outline),
        borderRadius: AppSizes.largeBorderRadius,
      ),
      child: Padding(
        padding: AppSizes.mediumPadding,
        child: Row(
          children: [
            _buildTitleAndSubtitle(context),
            const Icon(
              Icons.info,
              size: 64,
            ),
          ],
        ),
      ),
    );
  }

  Column _buildTitleAndSubtitle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSizes.medium,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Instructions',
          style: context.textTheme.titleLarge,
        ),
        const Text('How to use this app'),
      ],
    );
  }
}
