import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:spy_scanner/core/app_sizes.dart';
import 'package:spy_scanner/core/extension/context_theme.dart';

part 'onboard_mixin.dart';
part 'widgets/onboarding_page.dart';

class OnboardView extends StatefulWidget {
  const OnboardView({super.key});

  @override
  State<OnboardView> createState() => _OnboardViewState();
}

class _OnboardViewState extends State<OnboardView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
