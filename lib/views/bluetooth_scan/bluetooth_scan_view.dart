import 'package:auto_route/annotations.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:spy_scanner/core/app_sizes.dart';
import 'package:spy_scanner/core/extension/num_extension.dart';
import 'package:spy_scanner/core/logging/error_handler.dart';
import 'package:spy_scanner/feature/constants/lottie_assets.dart';

part 'bluetooth_scan_mixin.dart';
part 'device_result_model.dart';
part 'widgets/bluetooth_app_bar.dart';
part 'widgets/lottie_player.dart';
part 'widgets/device_list.dart';
part 'widgets/device_info_card.dart';

@RoutePage()
class BluetoothScanView extends StatefulWidget {
  const BluetoothScanView({super.key});

  @override
  State<BluetoothScanView> createState() => _BluetoothScanViewState();
}

class _BluetoothScanViewState extends State<BluetoothScanView>
    with _BluetoothScanMixin {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          _BluetoothAppBar(),
          _LottiePlayer(assetPath: LottieAssets.radar),
        ],
      ),
    );
  }
}
