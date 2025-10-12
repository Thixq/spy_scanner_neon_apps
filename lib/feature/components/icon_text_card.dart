import 'package:flutter/material.dart';
import 'package:spy_scanner/core/app_sizes.dart';
import 'package:spy_scanner/core/extension/context_theme.dart';

class IconTextCard extends StatelessWidget {
  const IconTextCard({
    required this.title,
    required this.icon,
    this.onPressed,
    super.key,
  });

  final String title;
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: AppSizes.largeBorderRadius,
        side: BorderSide(color: context.colorScheme.outline),
      ),
      child: InkWell(
        borderRadius: AppSizes.largeBorderRadius,
        onTap: onPressed,
        child: Padding(
          padding: AppSizes.mediumPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: AppSizes.small,
            children: [
              Icon(icon),
              Text(title, style: context.textTheme.titleSmall),
            ],
          ),
        ),
      ),
    );
  }
}
