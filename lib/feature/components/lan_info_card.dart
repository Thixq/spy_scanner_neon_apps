import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spy_scanner/core/app_sizes.dart';
import 'package:spy_scanner/core/extension/context_theme.dart';
import 'package:spy_scanner/feature/localization/localization_codegen/locale_keys.g.dart';

final String _ipAddressTitle = LocaleKeys.components_lan_info_card_ip_address
    .tr();
final String _connectionTitle = LocaleKeys.components_lan_info_card_connection
    .tr();
final String _notConnection = LocaleKeys.components_lan_info_card_not_connection
    .tr();
final String _wifi = LocaleKeys.components_lan_info_card_wifi.tr();

/// A widget that displays a card with IP address and connection information.
class LanInfoCard extends StatelessWidget {
  const LanInfoCard({
    this.ipAddress,
    this.connection,
    this.onPressed,
    super.key,
  });

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
                title: _ipAddressTitle,
                subtitle: ipAddress ?? _notConnection,
              ),
              _buildContentInfo(
                context,
                icon: Icons.router,
                title: _connectionTitle,
                subtitle: '$_wifi${connection ?? _notConnection}',
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
