import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spy_scanner/core/app_sizes.dart';
import 'package:spy_scanner/core/extension/context_theme.dart';
import 'package:spy_scanner/feature/localization/localization_codegen/locale_keys.g.dart';

final String _ipAddressTitle = LocaleKeys.components_status_info_card_ip_address
    .tr();
final String _connectionTitle = LocaleKeys.components_status_info_card_bluetooth
    .tr();
final String _bleStatus = LocaleKeys.components_status_info_card_ble_status
    .tr();
final String _notConnection = LocaleKeys
    .components_status_info_card_not_connection
    .tr();

/// A widget that displays a card with IP address and connection information.
class StatusInfoCard extends StatelessWidget {
  const StatusInfoCard({
    this.ipAddress,
    this.bleStatus = false,
    this.onPressed,
    super.key,
  });

  final String? ipAddress;
  final bool? bleStatus;
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
                icon: Icons.bluetooth_connected,
                title: _connectionTitle,
                subtitle: bleStatus! ? _bleStatus : _notConnection,
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
