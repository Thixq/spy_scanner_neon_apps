// ignore_for_file: discarded_futures, document_ignores

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
    if (!mounted) return;

    await ErrorHandler('LottiePlayer').executeSafely(
      () async {
        if (!mounted) return;

        if (isScanning) {
          if (_controller.isAnimating && !_controller.isCompleted) return;

          await _controller.repeat(reverse: true, min: 0, max: .6).orCancel;
        } else {
          if (_controller.isAnimating) {
            _controller.stop(canceled: false);
          }
          if (_controller.value < 1.0) {
            await _controller.animateTo(1).orCancel;
          }
        }
      },
      errorMessage: 'Canceled animation',
    );
  }

  @override
  void didUpdateWidget(covariant _LottiePlayer oldWidget) {
    if (oldWidget.isScanning != widget.isScanning) {
      _isScannig(widget.isScanning);
    }
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
