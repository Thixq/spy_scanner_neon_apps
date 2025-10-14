part of '../lan_scan_view.dart';

// part of '../scan_view.dart';

class _LottiePlayer extends StatelessWidget {
  const _LottiePlayer({
    required this.assetPath,
  });

  final String assetPath;

  @override
  Widget build(BuildContext context) {
    // Controller artık dışarıdan yönetildiği için build içinde bir şey yapmıyoruz.
    return SliverToBoxAdapter(
      child: Lottie.asset(
        assetPath,
        repeat: true,
        reverse: true,
        height: 30.h(context),
      ),
    );
  }
}
