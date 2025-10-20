part of '../paywall_bottom_sheet.dart';

class _ActionBar extends StatelessWidget {
  const _ActionBar();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
        onPressed: () {
          context.router.pop();
        },
        icon: const Icon(Icons.close),
      ),
    );
  }
}
