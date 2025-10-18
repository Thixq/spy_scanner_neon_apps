import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lottie/lottie.dart';
import 'package:spy_scanner/core/app_sizes.dart';
import 'package:spy_scanner/core/extension/context_theme.dart';
import 'package:spy_scanner/core/extension/num_extension.dart';
import 'package:spy_scanner/core/logging/error_handler.dart';
import 'package:spy_scanner/feature/constants/lottie_assets.dart';
import 'package:spy_scanner/feature/init/dependency_instances.dart';
import 'package:spy_scanner/feature/localization/localization_codegen/locale_keys.g.dart';
import 'package:spy_scanner/feature/managers/host_scanner_manager.dart';
import 'package:spy_scanner/feature/managers/service_discovery_manager.dart';
import 'package:spy_scanner/feature/models/host_model.dart';
import 'package:spy_scanner/feature/models/mdns_service_model.dart';

part 'lan_scan_mixin.dart';
part 'scan_type_enum.dart';
part 'scan_result_model.dart';
// view model
part 'view_model/scan_view_model.dart';
part 'view_model/scan_event.dart';
part 'view_model/scan_state.dart';
// widgets
part 'widgets/scan_app_bar.dart';
part 'widgets/lottie_player.dart';
part 'widgets/scan_button.dart';
part 'widgets/scan_info_item.dart';
part 'widgets/host_list.dart';
part 'widgets/button_viewer.dart';

@RoutePage()
class LanScanView extends StatefulWidget {
  const LanScanView({super.key});

  @override
  State<LanScanView> createState() => _LanScanViewState();
}

class _LanScanViewState extends State<LanScanView> with _ScanMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _viewModel,
      child: Scaffold(
        body: BlocBuilder<LanScanViewModel, _ScanState>(
          builder: (context, state) {
            return Stack(
              children: [
                CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    const _ScanAppBar(),
                    _LottiePlayer(
                      assetPath: assetPath,
                      isScanning: state is _ScanningScanState,
                    ),
                    _buildContent(context, state),
                    // dinamik padding ekleme
                    if (_isAtBottom) _buildBottomPadding(context),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.medium,
                  ),
                  child: _ButtonViewer(
                    onScan: _onScan,
                    onCancel: _onCancel,
                    isScanning: state is _ScanningScanState,
                    scanType: state is _ScanningScanState
                        ? state.scanType
                        : null,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildBottomPadding(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(height: 10.h(context)),
    );
  }

  Widget _buildContent(BuildContext context, _ScanState state) {
    if (state.items.isEmpty) {
      return SliverToBoxAdapter(
        child: Container(
          alignment: Alignment.center,
          height: 30.h(context),
          child: Text(
            LocaleKeys.views_lan_scan_scanned_yet_text.tr(),
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      );
    } else {
      return _HostList(results: state.items);
    }
  }
}
