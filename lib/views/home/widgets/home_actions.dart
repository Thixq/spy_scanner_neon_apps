part of '../home_view.dart';

final String _tabsOne = LocaleKeys.views_home_tabs_tab_one.tr();
final String _tabsTwo = LocaleKeys.views_home_tabs_tab_two.tr();

class _HomeActions extends StatelessWidget {
  const _HomeActions({
    required this.tabOneonPressed,
    required this.tabTwoonPressed,
  });

  final VoidCallback tabOneonPressed;
  final VoidCallback tabTwoonPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppSizes.medium,
      children: [
        Flexible(
          child: IconTextCard(
            icon: Icons.settings,
            title: _tabsOne,
            onPressed: tabOneonPressed,
          ),
        ),
        Flexible(
          child: IconTextCard(
            icon: Icons.privacy_tip,
            title: _tabsTwo,
            onPressed: tabTwoonPressed,
          ),
        ),
      ],
    );
  }
}
