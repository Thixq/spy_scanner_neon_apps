part of '../home_view.dart';

final String _appName = LocaleKeys.generic_app_name.tr();

class _HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _HomeAppBar({
    required this.onPremiumPressed,
    required this.onSettingsPressed,
  });

  final VoidCallback onPremiumPressed;
  final VoidCallback onSettingsPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(_appName),
      actions: [
        IconButton(
          onPressed: onPremiumPressed,
          icon: const Icon(Icons.workspace_premium),
        ),
        IconButton(
          onPressed: onSettingsPressed,
          icon: const Icon(Icons.settings),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
