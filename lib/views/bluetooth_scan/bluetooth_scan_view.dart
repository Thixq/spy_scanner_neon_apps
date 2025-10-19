import 'dart:async';
import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:lottie/lottie.dart';
import 'package:spy_scanner/core/app_sizes.dart';
import 'package:spy_scanner/core/extension/context_theme.dart';
import 'package:spy_scanner/core/extension/num_extension.dart';
import 'package:spy_scanner/core/logging/error_handler.dart';
import 'package:spy_scanner/feature/constants/lottie_assets.dart';
import 'package:spy_scanner/feature/init/dependency_instances.dart';
import 'package:spy_scanner/feature/localization/localization_codegen/locale_keys.g.dart';
import 'package:spy_scanner/feature/managers/ble_scanner_manager.dart';
import 'package:spy_scanner/feature/monitoring/bluetooth_status_monitor.dart';

part 'bluetooth_scan_mixin.dart';
part 'device_result_model.dart';
part 'view_model/bluetooth_scan_state.dart';
part 'view_model/bluetooth_scan_event.dart';
part 'view_model/bluetooth_scan_view_model.dart';
part 'widgets/bluetooth_app_bar.dart';
part 'widgets/lottie_player.dart';
part 'widgets/device_list.dart';
part 'widgets/device_info_card.dart';
part 'widgets/scan_button.dart';

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
    return BlocProvider.value(
      value: _viewModel,
      child: Scaffold(
        body: BlocBuilder<_BluetoothScanViewModel, _BluetoothScanState>(
          builder: (context, state) => Stack(
            children: [
              CustomScrollView(
                controller: _scrollController,
                slivers: [
                  const _BluetoothAppBar(),
                  _LottiePlayer(
                    assetPath: LottieAssets.radar,
                    isScanning: state is _ScanningBluetoothScanState,
                  ),
                  _buildContent(context, state),
                  if (_isAtBottom) _buildBottomPadding(context),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.medium,
                ),
                child: _ScanButton(
                  isScanning: state is _ScanningBluetoothScanState,
                  onScan: _onScan,
                  onCancel: _onCancel,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildBottomPadding(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(height: 10.h(context)),
    );
  }

  Widget _buildContent(BuildContext context, _BluetoothScanState state) {
    if (state.items.isEmpty) {
      return SliverToBoxAdapter(
        child: Container(
          alignment: Alignment.center,
          height: 30.h(context),
          child: Text(
            LocaleKeys.views_bluetooth_scan_scanned_yet_text.tr(),
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      );
    } else {
      return _DeviceList(results: state.items);
    }
  }
}
