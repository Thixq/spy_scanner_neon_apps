part of '../home_view.dart';

class _HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _HomeAppBar({required this.onPremiumPressed});

  final VoidCallback onPremiumPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Spy Scanner'),
      actions: [
        IconButton(
          onPressed: onPremiumPressed,
          icon: const Icon(Icons.workspace_premium),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
