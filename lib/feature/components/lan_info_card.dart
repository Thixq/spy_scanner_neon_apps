import 'package:flutter/material.dart';

class LanInfoCard extends StatelessWidget {
  const LanInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.red),
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'LAN Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('IP Address: 192.168.1.1'),
            Text('Subnet Mask: 255.255.255.0'),
            Text('Gateway: 192.168.1.254'),
          ],
        ),
      ),
    );
  }
}
