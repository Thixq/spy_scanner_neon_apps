import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:spy_scanner/core/app_sizes.dart';
import 'package:spy_scanner/core/extension/context_theme.dart';
import 'package:spy_scanner/feature/constants/lottie_assets.dart';

class DevOnboardView extends StatefulWidget {
  const DevOnboardView({super.key});

  @override
  State<DevOnboardView> createState() => _DevOnboardViewState();
}

class _DevOnboardViewState extends State<DevOnboardView> {
  final PageController pageController = PageController();
  int currentPage = 0; // 🔹 aktif sayfa

  @override
  void initState() {
    super.initState();
    pageController.addListener(_pageListener);
  }

  void _pageListener() {
    final page = pageController.page?.round() ?? 0;
    if (page != currentPage) {
      setState(() => currentPage = page);
    }
  }

  @override
  void dispose() {
    pageController
      ..removeListener(_pageListener)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const totalPages = 3;
    final isLastPage = currentPage == totalPages - 1;

    return Scaffold(
      body: SafeArea(
        child: Column(
          spacing: 16,
          children: [
            Flexible(
              child: PageView.builder(
                controller: pageController,
                itemCount: totalPages,
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
            OnboardingIndicator(
              pageController: pageController,
              isLastPage: isLastPage,
              onNext: () async {
                if (isLastPage) {
                  // 🔹 Son sayfadaysa yönlendirme yapılabilir
                  //print('Onboarding tamamlandı!');
                  // örn: Navigator.pushReplacementNamed(context, '/home');
                } else {
                  // 🔹 Diğer sayfaya geç
                  await pageController.nextPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                }
              },
              onPrevious: () async {
                if (currentPage > 0) {
                  await pageController.previousPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingIndicator extends StatelessWidget {
  const OnboardingIndicator({
    required this.pageController,
    required this.isLastPage,
    required this.onNext,
    required this.onPrevious,
    super.key,
  });

  final PageController pageController;
  final bool isLastPage;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          onPressed: onPrevious,
          child: const Text('Previous'),
        ),
        SmoothPageIndicator(
          controller: pageController,
          count: 3,
          effect: WormEffect(
            dotHeight: AppSizes.small,
            dotWidth: AppSizes.small,

            activeDotColor: context.colorScheme.primary,
          ),
        ),
        TextButton(
          onPressed: onNext,
          child: Text(isLastPage ? 'Done' : 'Next'),
        ),
      ],
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
