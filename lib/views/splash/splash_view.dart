import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:spy_scanner/core/extension/num_extension.dart';
import 'package:spy_scanner/feature/constants/image_assets.dart';
import 'package:spy_scanner/feature/init/dependency_instances.dart';
import 'package:spy_scanner/feature/routing/app_routing.gr.dart';

part 'logo_builder.dart';
part 'splash_mixin.dart';

@RoutePage()
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with _SplashMixin {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: _LogoBuilder(),
      ),
    );
  }
}
