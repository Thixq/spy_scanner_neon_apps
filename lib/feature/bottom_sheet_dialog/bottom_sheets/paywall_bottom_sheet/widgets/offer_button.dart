part of '../paywall_bottom_sheet.dart';

class _OfferButton extends StatelessWidget {
  const _OfferButton({
    required this.title,
    required this.subTitle,
    required this.onPressed,
  });

  final String title;
  final String subTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
      style: FilledButton.styleFrom(
        side: BorderSide(color: context.colorScheme.outline),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(
          vertical: AppSizes.medium,
          horizontal: AppSizes.medium,
        ),
      ),
      onPressed: onPressed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.textTheme.titleMedium?.copyWith(
              color: context.colorScheme.onPrimaryContainer,
            ),
          ),
          Text(
            subTitle,
            style: context.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
