part of '../home_view.dart';

final String _infoCardTitle = LocaleKeys.views_home_info_card_title.tr();
final String _infoCardDescription = LocaleKeys.views_home_info_card_description
    .tr();

class _HomeInfoCard extends StatelessWidget {
  const _HomeInfoCard();

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      title: _infoCardTitle,
      description: _infoCardDescription,
    );
  }
}
