import 'package:flutter/material.dart';

class DevComponentView extends StatelessWidget {
  const DevComponentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dev Components')),
      body: const Center(child: Text('Development Components Here')),
    );
  }
}
