part of '../paywall_bottom_sheet.dart';

final _offers = <String>[
  LocaleKeys.paywall_offer_offer_one.tr(),
  LocaleKeys.paywall_offer_offer_two.tr(),
  LocaleKeys.paywall_offer_offer_three.tr(),
  LocaleKeys.paywall_offer_offer_four.tr(),
  LocaleKeys.paywall_offer_offer_five.tr(),
];
final String _title = LocaleKeys.paywall_title.tr();

class _FeatureList extends StatelessWidget {
  const _FeatureList();

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSizes.extraLarge,
      children: [
        Text(
          _title,
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        MutliTextLine(
          spacing: AppSizes.medium,
          style: context.textTheme.bodyLarge,
          lines: _offers,
        ),
      ],
    );
  }
}
