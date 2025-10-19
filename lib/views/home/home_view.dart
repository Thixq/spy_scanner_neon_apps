import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:spy_scanner/core/app_sizes.dart';
import 'package:spy_scanner/feature/bottom_sheet_dialog/paywall_bottom_sheet/paywall_bottom_sheet.dart';
import 'package:spy_scanner/feature/bottom_sheet_dialog/text_bottom_sheet.dart';
import 'package:spy_scanner/feature/components/icon_text_card.dart';
import 'package:spy_scanner/feature/components/info_card.dart';
import 'package:spy_scanner/feature/components/lan_info_card.dart';
import 'package:spy_scanner/feature/components/scan_card/scan_card.dart';
import 'package:spy_scanner/feature/init/dependency_instances.dart';
import 'package:spy_scanner/feature/localization/localization_codegen/locale_keys.g.dart';
import 'package:spy_scanner/feature/models/wifi_info_model.dart';
import 'package:spy_scanner/feature/monitoring/bluetooth_status_monitor.dart';
import 'package:spy_scanner/feature/monitoring/wifi_status_monitor.dart';
import 'package:spy_scanner/feature/routing/app_routing.gr.dart';

part 'home_mixin.dart';
part 'view_model/home_view_model.dart';
part 'view_model/home_state.dart';
part 'widgets/home_app_bar.dart';
part 'widgets/home_scanners.dart';
part 'widgets/home_info_card.dart';
part 'widgets/home_actions.dart';

@RoutePage()
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with _HomeMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _viewModel,
      child: Scaffold(
        appBar: _HomeAppBar(
          onPremiumPressed: _paywall,
        ),
        body: SafeArea(
          child: Padding(
            padding: AppSizes.mediumPadding,
            child: Column(
              spacing: AppSizes.medium,
              children: [
                _buildLanInfo(),
                _buildScanners(),
                const _HomeInfoCard(),
                _HomeActions(
                  tabOneonPressed: () {},
                  tabTwoonPressed: () async {
                    await TextBottomSheet.show(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScanners() {
    return BlocBuilder<_HomeViewModel, _HomeState>(
      builder: (context, state) {
        return _Scanners(
          scanners: _scanners,
          onWifiScanPressed: _goLanScanView,
          onBluetoothScanPressed: _goBluetoothScanView,
          onInfraredScanPressed: () {},
          isBluetoothDisabled: state.bluetoothState is _BluetoothDisabled,
          isWifiDisabled: state.wifiState is _WifiDisabled,
        );
      },
    );
  }

  Widget _buildLanInfo() {
    String? localIp;
    String? connection;
    return BlocBuilder<_HomeViewModel, _HomeState>(
      buildWhen: (previous, current) => previous.wifiState != current.wifiState,
      builder: (context, state) {
        if (state.wifiState is _WifiEnabled) {
          final wifiState = state.wifiState! as _WifiEnabled;
          localIp = wifiState.wifiInfo.localIp;
          connection = wifiState.wifiInfo.wifiName;
        } else {
          localIp = null;
          connection = null;
        }
        return LanInfoCard(
          ipAddress: localIp,
          connection: connection,
        );
      },
    );
  }
}
