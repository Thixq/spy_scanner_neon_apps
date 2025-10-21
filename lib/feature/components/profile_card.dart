import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spy_scanner/core/app_sizes.dart';
import 'package:spy_scanner/core/extension/context_theme.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.medium),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSizes.medium,
          children: [
            const CircleAvatar(
              minRadius: AppSizes.extraLarge,
              maxRadius: AppSizes.extraLarge * 1.5,
              child: Icon(
                CupertinoIcons.person,
                size: AppSizes.extraLarge * 1.5,
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '542d877d-d919',
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
