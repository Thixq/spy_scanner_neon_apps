part of '../paywall_bottom_sheet.dart';

final String _monthly = LocaleKeys.paywall_price_options_option_one_title.tr();
final String _paymentMonthly = LocaleKeys
    .paywall_price_options_option_one_payment_method
    .tr();
final String _lifetime = LocaleKeys.paywall_price_options_option_two_title.tr();
final String _paymentLifetime = LocaleKeys
    .paywall_price_options_option_two_payment_method
    .tr();

const double _monthlyPrice = 19.99;
const double _lifetimePrice = 239.99;

class _OfferButtonList extends StatelessWidget {
  _OfferButtonList({
    required this.onMonthlyPressed,
    required this.onLifetimePressed,
  });

  final ValueChanged<Map<String, dynamic>?> onMonthlyPressed;
  final ValueChanged<Map<String, dynamic>?> onLifetimePressed;

  final PaymentService paymentService = DependencyInstances.service.payment;
  final items = [
    PaymentItem(
      label: _paymentMonthly,
      amount: _monthlyPrice.toString(),
      status: PaymentItemStatus.final_price,
    ),
    PaymentItem(
      label: _paymentLifetime,
      amount: _lifetimePrice.toString(),
      status: PaymentItemStatus.final_price,
    ),
  ];

  Future<Map<String, dynamic>?> onMonthlyPayment() async {
    if (Platform.isAndroid) {
      return paymentService.googlePay(items: [items[0]]);
    } else if (Platform.isIOS) {
      return paymentService.applePay(items: [items[0]]);
    }
    return null;
  }

  Future<Map<String, dynamic>?> onLifetimePayment() async {
    if (Platform.isAndroid) {
      return paymentService.googlePay(items: [items[1]]);
    } else if (Platform.isIOS) {
      return paymentService.applePay(items: [items[1]]);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final monthlyPrice = LocaleKeys.paywall_price_options_option_one_price.tr(
      namedArgs: {'price': PriceFormatter.format(_monthlyPrice, context)},
    );
    final lifetimePrice = LocaleKeys.paywall_price_options_option_two_price.tr(
      namedArgs: {'price': PriceFormatter.format(_lifetimePrice, context)},
    );
    return Column(
      spacing: AppSizes.medium,
      children: [
        SizedBox(
          width: double.infinity,
          child: _OfferButton(
            title: _monthly,
            subTitle: monthlyPrice,
            onPressed: () async => onMonthlyPressed(await onMonthlyPayment()),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: _OfferButton(
            title: _lifetime,
            subTitle: lifetimePrice,
            onPressed: () async => onLifetimePressed(await onLifetimePayment()),
          ),
        ),
      ],
    );
  }
}
