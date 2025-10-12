part of '../home_view.dart';

class _HomeActions extends StatelessWidget {
  const _HomeActions({
    required this.onSettingsPressed,
    required this.onFaqPressed,
  });

  final VoidCallback onSettingsPressed;
  final VoidCallback onFaqPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppSizes.medium,
      children: [
        Flexible(
          child: IconTextCard(
            icon: Icons.settings,
            title: 'Settings',
            onPressed: onSettingsPressed,
          ),
        ),
        Flexible(
          child: IconTextCard(
            icon: Icons.question_mark,
            title: 'FAQ',
            onPressed: onFaqPressed,
          ),
        ),
      ],
    );
  }
}
