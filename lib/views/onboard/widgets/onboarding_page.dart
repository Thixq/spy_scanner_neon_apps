part of '../onboard_view.dart';

/// A widget that displays an onboarding page.
///
/// [onboardingPageModel] is the model of the onboarding page.
class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({
    required this.onboardingPageModel,
  });

  final _OnboardingPageModel onboardingPageModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        LottieBuilder.asset(
          height: AppSizes.extraLarge * 5,
          onboardingPageModel.lottiePath,
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
                onboardingPageModel.title,
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.onSurface,
                ),
              ),
              Text(
                onboardingPageModel.description,
                style: context.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
