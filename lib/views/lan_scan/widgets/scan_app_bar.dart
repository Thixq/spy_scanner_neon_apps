part of '../lan_scan_view.dart';

final String _viewTitle = LocaleKeys.views_lan_scan_title.tr();

class _ScanAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _ScanAppBar({required this.onSave});
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      actions: [IconButton(onPressed: onSave, icon: const Icon(Icons.save))],
      pinned: true,
      title: Text(_viewTitle),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
