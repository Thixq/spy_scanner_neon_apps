import 'package:flutter/material.dart';
import 'package:spy_scanner/core/app_sizes.dart';
import 'package:spy_scanner/core/extension/context_theme.dart';

/// A widget that displays a card with a title, subtitle, and optional button.
/// It also supports disabling the card by setting [isDisabled] to true.
///
/// [icon] is the icon of the card.
/// [contentTitle] is the title of the card.
/// [contentSubTitle] is the subtitle of the card.
/// [buttonText] is the text of the button.
/// [onPressed] is the callback that is called when the button is pressed.
/// [isDisabled] is a flag that indicates whether the card is disabled or not.
class ScanCard extends StatelessWidget {
  // StatelessWidget olarak değiştirildi
  const ScanCard({
    required this.contentTitle,
    required this.icon,
    this.contentSubTitle,
    super.key,
    this.buttonText,
    this.onPressed,
    this.isDisabled = false,
    this.buttonOnPressed,
  });

  final String contentTitle;
  final String? contentSubTitle;
  final String? buttonText;
  final VoidCallback? buttonOnPressed;
  final VoidCallback? onPressed;
  final IconData icon;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[
      _buildContentIcon(context, icon), // Özelliğe doğrudan erişim
      _buildTitleAndSubTitle(
        context,
        title: contentTitle, // Özelliğe doğrudan erişim
        subTitle: contentSubTitle, // Özelliğe doğrudan erişim
      ),
    ];

    if (buttonOnPressed != null) {
      // Özelliğe doğrudan erişim
      children.add(
        _buildContentButton(
          buttonText: buttonText,
          onPressed: buttonOnPressed,
        ),
      );
    }

    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Theme.of(context).colorScheme.outline),
        borderRadius: AppSizes.largeBorderRadius,
      ),
      child: InkWell(
        borderRadius: AppSizes.largeBorderRadius,
        onTap: isDisabled ? null : onPressed,
        child: Padding(
          padding: AppSizes.mediumPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ),
    );
  }

  Widget _buildContentIcon(BuildContext context, IconData iconData) {
    return CircleAvatar(
      radius: AppSizes.large,
      child: Icon(
        iconData,
      ),
    );
  }

  // Sınıf özelliklerine doğrudan erişiyor (this.isDisabled, this.onPressed, etc.)
  Widget _buildContentButton({
    String? buttonText,
    VoidCallback? onPressed,
  }) {
    return FilledButton(
      onPressed: isDisabled ? null : onPressed,
      child: buttonText != null ? Text(buttonText) : null,
    );
  }

  Widget _buildTitleAndSubTitle(
    BuildContext context, {
    required String title,
    String? subTitle,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSizes.small,
      children: [
        Text(
          title,
          style: context.textTheme.titleLarge,
        ),
        if (subTitle != null) ...[
          Text(
            subTitle,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.bodySmall,
          ),
        ],
      ],
    );
  }
}
