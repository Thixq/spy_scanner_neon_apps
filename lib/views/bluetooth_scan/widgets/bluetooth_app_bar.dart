part of '../bluetooth_scan_view.dart';

class _BluetoothAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _BluetoothAppBar();

  @override
  Widget build(BuildContext context) {
    return const SliverAppBar(
      pinned: true,
      title: Text('Bluettoth Scanner'),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
