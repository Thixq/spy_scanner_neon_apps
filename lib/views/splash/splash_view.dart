import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:spy_scanner/core/extension/num_extension.dart';
import 'package:spy_scanner/feature/constants/image_assets.dart';

part 'logo_builder.dart';

@RoutePage()
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: _LogoBuilder(),
      ),
    );
  }
}
