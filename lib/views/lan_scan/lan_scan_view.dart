import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lottie/lottie.dart';
import 'package:spy_scanner/core/app_sizes.dart';
import 'package:spy_scanner/core/extension/num_extension.dart';
import 'package:spy_scanner/feature/constants/lottie_assets.dart';
import 'package:spy_scanner/feature/localization/localization_codegen/locale_keys.g.dart';
import 'package:spy_scanner/feature/models/host_model.dart';
import 'package:spy_scanner/views/lan_scan/view_model/scan_event.dart';
import 'package:spy_scanner/views/lan_scan/view_model/scan_state.dart';
import 'package:spy_scanner/views/lan_scan/view_model/scan_view_model.dart';

part 'lan_scan_mixin.dart';
part 'widgets/scan_app_bar.dart';
part 'widgets/lottie_player.dart';
part 'widgets/scan_button.dart';
part 'widgets/device_item.dart';
part 'widgets/host_list.dart';

@RoutePage()
class LanScanView extends StatefulWidget {
  const LanScanView({super.key});

  @override
  State<LanScanView> createState() => _LanScanViewState();
}

class _LanScanViewState extends State<LanScanView> with _ScanMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LanScanViewModel, ScanState>(
        builder: (context, state) {
          print('------------------ State: $state ----------------');
          return Stack(
            children: [
              CustomScrollView(
                slivers: [
                  const _ScanAppBar(),
                  _LottiePlayer(
                    assetPath: assetPath,
                  ),
                  _HostList(
                    hostList: state.items,
                  ),
                ],
              ),
              _ScanButton(
                isScanning: state is! IdleScanState,
                onScan: _onScan,
                onCancel: _onCancel,
              ),
            ],
          );
        },
      ),
    );
  }
}
