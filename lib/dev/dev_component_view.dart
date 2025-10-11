import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';

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
          child: Row(
            spacing: 16,
            children: [
              Expanded(
                child: ScanCard(
                  icon: Icons.wifi_find,
                  contentTitle: 'Pingable Devices',
                  contentSubTitle:
                      'Scan for devices that respond to ping requests.',
                  buttonText: 'Scan Pingable',
                  onPressed: () {},
                ),
              ),
              const Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ScanCard(
                      icon: Icons.bluetooth,
                      contentTitle: 'Bluetooth Devices',
                    ),
                    SizedBox(height: 16),
                    ScanCard(
                      isDisabled: true,
                      icon: CupertinoIcons.camera_viewfinder,
                      contentTitle: 'Camera Decator',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
