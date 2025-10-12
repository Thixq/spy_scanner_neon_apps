import 'package:flutter/material.dart';
import 'package:spy_scanner/core/app_sizes.dart';
import 'package:spy_scanner/core/extension/context_theme.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    required this.title,
    super.key,
    this.onPressed,
    this.subTitle,
  });

  final void Function()? onPressed;
  final String title;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: context.colorScheme.outline),
        borderRadius: AppSizes.largeBorderRadius,
      ),
      child: InkWell(
        borderRadius: AppSizes.largeBorderRadius,
        onTap: onPressed,
        child: Padding(
          padding: AppSizes.mediumPadding,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: _buildTitleAndSubtitle(
                  context,
                  title: title,
                  subTitle: subTitle,
                ),
              ),
              Image.asset(
                'assets/images/img_security_camera.png',
                width: 125,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column _buildTitleAndSubtitle(
    BuildContext context, {
    required String title,
    String? subTitle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSizes.medium,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: context.textTheme.titleLarge,
        ),
        if (subTitle != null) ...[
          Text(
            subTitle,
            style: context.textTheme.bodySmall,
          ),
        ],
      ],
    );
  }
}
