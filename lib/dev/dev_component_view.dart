import 'package:flutter/material.dart';
import 'package:spy_scanner/feature/components/lan_info_card.dart';

class DevComponentView extends StatelessWidget {
  const DevComponentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dev Components')),
      body: const Center(
        child: LanInfoCard(
          ipAddress: '244.178.44.111',
          connection: 'Neon Apps',
        ),
      ),
    );
  }
}
