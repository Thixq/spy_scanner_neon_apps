part of '../bluetooth_scan_view.dart';

final String _viewTitle = LocaleKeys.views_bluetooth_scan_title.tr();

class _BluetoothAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _BluetoothAppBar();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      title: Text(_viewTitle),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
