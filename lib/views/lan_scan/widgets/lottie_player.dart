part of '../lan_scan_view.dart';

// part of '../scan_view.dart';

class _LottiePlayer extends StatefulWidget {
  const _LottiePlayer({
    required this.assetPath,
    this.isScanning = false,
  });

  final String assetPath;
  final bool isScanning;

  @override
  State<_LottiePlayer> createState() => _LottiePlayerState();
}

class _LottiePlayerState extends State<_LottiePlayer>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  Future<void> _isScannig(bool isScanning) async {
    await ErrorHandler('LottiePlayer').executeSafely(
      () async {
        if (isScanning) {
          await _controller.repeat(reverse: true, min: 0, max: 0.8).orCancel;
        } else {
          await _controller.forward(from: 1);
        }
      },
      errorMessage: 'Canceled animation',
    );
  }

  @override
  void didUpdateWidget(covariant _LottiePlayer oldWidget) {
    _isScannig(widget.isScanning);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _isScannig(widget.isScanning);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Controller artık dışarıdan yönetildiği için build içinde bir şey yapmıyoruz.
    return SliverToBoxAdapter(
      child: Lottie.asset(
        widget.assetPath,
        controller: _controller,
        repeat: true,
        reverse: true,
        height: 30.h(context),
      ),
    );
  }
}
