import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';
import 'package:spy_scanner/feature/components/lan_info_card.dart';

import 'package:spy_scanner/feature/components/scan_card.dart';

class DevComponentView extends StatelessWidget {
  const DevComponentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dev Components')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            spacing: 16,
            children: [
              const LanInfoCard(
                ipAddress: '89.0.142.86',
                connection: 'Connected',
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 16,
                children: [
                  Flexible(
                    child: ScanCard(
                      icon: Icons.wifi_find,
                      contentTitle: 'Pingable Devices',
                      contentSubTitle:
                          'Scan for devices that respond to ping requests.',
                      buttonText: 'Scan Pingable',
                      onPressed: () {},
                    ),
                  ),
                  const Flexible(
                    child: Column(
                      spacing: 16,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: ScanCard(
                            icon: Icons.bluetooth,
                            contentTitle: 'Bluetooth Devices',
                          ),
                        ),

                        Flexible(
                          child: ScanCard(
                            isDisabled: true,
                            icon: CupertinoIcons.camera_viewfinder,
                            contentTitle: 'Camera Decator',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
