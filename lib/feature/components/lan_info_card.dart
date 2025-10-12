import 'package:flutter/material.dart';
import 'package:spy_scanner/core/app_sizes.dart';
import 'package:spy_scanner/core/extension/context_theme.dart';

const ipAddressTitle = 'IP Address';
const connectionTitle = 'Connection';
const notConnection = 'Not connected';

/// A widget that displays a card with IP address and connection information.
class LanInfoCard extends StatelessWidget {
  const LanInfoCard({
    this.ipAddress,
    this.connection,
    this.onPressed,
    super.key,
  });

  // Tüm özellikler final ve doğrudan sınıf içinde erişilebilir
  final String? ipAddress;
  final String? connection;
  final VoidCallback? onPressed;

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildContentInfo(
                context,
                icon: Icons.language,
                title: ipAddressTitle,
                subtitle:
                    ipAddress ?? notConnection, // Doğrudan özellik erişimi
              ),
              _buildContentInfo(
                context,
                icon: Icons.router,
                title: connectionTitle,
                subtitle:
                    'Wi-Fi: ${connection ?? notConnection}', // Doğrudan özellik erişimi
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column _buildContentInfo(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Column(
      spacing: AppSizes.small,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          spacing: AppSizes.small,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon),
            Text(
              title,
              style: context.textTheme.titleMedium,
            ),
          ],
        ),
        Text(subtitle, style: context.textTheme.bodySmall),
      ],
    );
  }
}
