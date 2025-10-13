import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';
import 'package:spy_scanner/core/app_sizes.dart';
import 'package:spy_scanner/feature/bottom_sheet_dialog/paywall_bottom_sheet/paywall_bottom_sheet.dart';
import 'package:spy_scanner/feature/bottom_sheet_dialog/text_bottom_sheet.dart';
import 'package:spy_scanner/feature/components/icon_text_card.dart';
import 'package:spy_scanner/feature/components/info_card.dart';
import 'package:spy_scanner/feature/components/lan_info_card.dart';
import 'package:spy_scanner/feature/components/scan_card/scan_card.dart';
import 'package:spy_scanner/feature/localization/localization_codegen/locale_keys.g.dart';

part 'home_mixin.dart';
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
    return Scaffold(
      appBar: _HomeAppBar(
        onPremiumPressed: () async {
          await PaywallBottomSheet.show(context);
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: AppSizes.mediumPadding,
          child: Column(
            spacing: AppSizes.medium,
            children: [
              _buildLanInfo(),
              _Scanners(
                scanners: _scanners,
                onWifiScanPressed: () {},
                onBluetoothScanPressed: () {},
                onInfraredScanPressed: () {},
              ),
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
    );
  }

  LanInfoCard _buildLanInfo({
    String? ipAddress,
    String? connection,
  }) {
    return LanInfoCard(
      ipAddress: ipAddress,
      connection: connection,
    );
  }
}
