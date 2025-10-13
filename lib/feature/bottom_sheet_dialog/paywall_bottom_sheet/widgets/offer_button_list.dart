part of '../paywall_bottom_sheet.dart';

final String _monthly = LocaleKeys.paywall_price_options_option_one_title.tr();

final String _lifetime = LocaleKeys.paywall_price_options_option_two_title.tr();

class _OfferButtonList extends StatelessWidget {
  const _OfferButtonList({
    required this.onMonthlyPressed,
    required this.onLifetimePressed,
  });

  final VoidCallback onMonthlyPressed;
  final VoidCallback onLifetimePressed;

  @override
  Widget build(BuildContext context) {
    final monthlyPrice = LocaleKeys.paywall_price_options_option_one_price.tr(
      namedArgs: {'price': PriceFormatter.format(19.99, context)},
    );
    final lifetimePrice = LocaleKeys.paywall_price_options_option_two_price.tr(
      namedArgs: {'price': PriceFormatter.format(239.99, context)},
    );
    return Column(
      spacing: AppSizes.medium,
      children: [
        SizedBox(
          width: double.infinity,
          child: _OfferButton(
            title: _monthly,
            subTitle: monthlyPrice,
            onPressed: onMonthlyPressed,
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: _OfferButton(
            title: _lifetime,
            subTitle: lifetimePrice,
            onPressed: onLifetimePressed,
          ),
        ),
      ],
    );
  }
}
