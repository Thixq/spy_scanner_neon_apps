import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:spy_scanner/core/app_sizes.dart';
import 'package:spy_scanner/core/extension/context_theme.dart';
import 'package:spy_scanner/feature/constants/lottie_assets.dart';
import 'package:spy_scanner/feature/routing/app_routing.gr.dart';

part 'onboard_mixin.dart';
part 'onboarding_page_model.dart';
part 'widgets/onboarding_indicator.dart';
part 'widgets/onboarding_page.dart';

@RoutePage()
class OnboardView extends StatefulWidget {
  const OnboardView({super.key});

  @override
  State<OnboardView> createState() => _OnboardViewState();
}

class _OnboardViewState extends State<OnboardView> with _OnboardMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          spacing: AppSizes.medium,
          children: [
            _buildPage(),
            _OnboardingIndicator(
              pageController: _pageController,
              onNext: _onNext,
              onPrevious: _onPrevious,
              isLastPage: isLastPage,
            ),
          ],
        ),
      ),
    );
  }

  Expanded _buildPage() {
    return Expanded(
      child: PageView.builder(
        itemCount: _pages.length,
        controller: _pageController,
        itemBuilder: (context, index) {
          final page = _pages[index];
          return _OnboardingPage(
            onboardingPageModel: page,
          );
        },
      ),
    );
  }
}
