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
class ScanCard extends StatefulWidget {
  const ScanCard({
    required this.contentTitle,
    required this.icon,
    this.contentSubTitle,
    super.key,
    this.buttonText,
    this.onPressed,
    this.isDisabled = false,
  });

  final String contentTitle;
  final String? contentSubTitle;
  final String? buttonText;
  final VoidCallback? onPressed;
  final IconData icon;
  final bool isDisabled;

  @override
  State<ScanCard> createState() => _ScanCardState();
}

class _ScanCardState extends State<ScanCard> {
  @override
  void didUpdateWidget(covariant ScanCard oldWidget) {
    if (oldWidget.isDisabled != widget.isDisabled) {
      setState(() {});
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    // Çocukları koşullu oluşturuyoruz; buton yoksa listeye eklemiyoruz -> spacing otomatik
    final children = <Widget>[
      _buildContentIcon(context, widget.icon),
      _buildTitleAndSubTitle(
        context,
        title: widget.contentTitle,
        subTitle: widget.contentSubTitle,
      ),
    ];

    // Eğer onPressed varsa butonu ve ondan önceki boşluğu ekle
    if (widget.onPressed != null) {
      children.add(_buildContentButton());
    }

    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Theme.of(context).colorScheme.outline),
        borderRadius: AppSizes.largeBorderRadius,
      ),
      child: Padding(
        padding: AppSizes.mediumPadding,
        child: Column(
          spacing: widget.onPressed != null
              ? AppSizes.extraLarge
              : AppSizes.medium,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }

  CircleAvatar _buildContentIcon(BuildContext context, IconData iconData) {
    return CircleAvatar(
      radius: AppSizes.large,
      child: Icon(
        iconData,
      ),
    );
  }

  Widget _buildContentButton() {
    return FilledButton(
      onPressed: widget.isDisabled ? null : widget.onPressed,
      child: widget.buttonText != null ? Text(widget.buttonText!) : null,
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
          Text(subTitle, style: context.textTheme.bodySmall),
        ],
      ],
    );
  }
}
