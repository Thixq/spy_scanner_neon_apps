import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:spy_scanner/core/app_sizes.dart';
import 'package:spy_scanner/core/extension/context_theme.dart';
import 'package:spy_scanner/feature/constants/lottie_assets.dart';

class DevOnboardView extends StatefulWidget {
  const DevOnboardView({super.key});

  @override
  State<DevOnboardView> createState() => _DevOnboardViewState();
}

class _DevOnboardViewState extends State<DevOnboardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          spacing: 16,
          children: [
            Flexible(
              child: PageView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return OnboardingPage(
                    title: 'Kızıl Ötesi Sensor Tespiti',
                    description:
                        'Kameraya yakalanan kızıl ötesi ışınları tespit ederek izlenmediğinizden emin olun. ' *
                        3,
                    lottiePath: LottieAssets.brotherEye,
                  );
                },
              ),
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text('Skip'),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: const Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    required this.title,
    required this.description,
    required this.lottiePath,
    super.key,
  });

  final String title;
  final String description;
  final String lottiePath;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        LottieBuilder.asset(
          height: AppSizes.extraLarge * 5,
          lottiePath,
          errorBuilder: (context, error, stackTrace) => const Icon(
            Icons.error,
            size: AppSizes.extraLarge * 3,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.medium),
          child: Column(
            spacing: AppSizes.small,
            children: [
              Text(
                title,
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.onSurface,
                ),
              ),
              Text(
                description,
                style: context.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
