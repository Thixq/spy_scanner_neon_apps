import 'package:flutter/material.dart';
import 'package:spy_scanner/core/app_sizes.dart';
import 'package:spy_scanner/core/extension/context_theme.dart';

part 'scan_card_model.dart';

/// A widget that displays a card with a title, subtitle, and optional button.
/// It also supports disabling the card by setting [isDisabled] to true.
///
/// [scanner] is the model of the card.
/// [onCardPressed] is the callback function that is called when the card is pressed.
/// [onButtonPressed] is the callback function that is called when the button is pressed.
/// [isDisabled] is a flag that indicates whether the card is disabled or not.
class ScanCard extends StatelessWidget {
  // StatelessWidget olarak değiştirildi
  const ScanCard({
    required this.scanner,
    super.key,
    this.isDisabled = false,
    this.onCardPressed,
    this.onButtonPressed,
  });

  final ScanCardModel scanner;
  final VoidCallback? onCardPressed;
  final VoidCallback? onButtonPressed;

  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[
      _buildContentIcon(context, scanner.icon), // Özelliğe doğrudan erişim
      _buildTitleAndSubTitle(
        context,
        title: scanner.contentTitle, // Özelliğe doğrudan erişim
        subTitle: scanner.contentSubTitle, // Özelliğe doğrudan erişim
      ),
    ];

    if (onButtonPressed != null) {
      // Özelliğe doğrudan erişim
      children.add(
        _buildContentButton(
          buttonText: scanner.buttonText,
          onPressed: onButtonPressed,
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
        onTap: isDisabled ? null : onCardPressed,
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
      minRadius: AppSizes.small,
      maxRadius: AppSizes.large,
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
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSizes.small,
      children: [
        Text(
          title,
          style: context.textTheme.titleMedium,
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
