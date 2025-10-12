part of '../onboard_view.dart';

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({
    required this.title,
    required this.description,
    required this.lottiePath,
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
