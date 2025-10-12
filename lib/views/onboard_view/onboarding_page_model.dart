part of 'onboard_view.dart';

/// A model for an onboarding page.
///
/// It contains the title, description, and the path of the lottie animation.
final class _OnboardingPageModel {
  const _OnboardingPageModel({
    required this.title,
    required this.description,
    required this.lottiePath,
  });

  /// The title of the onboarding page.
  final String title;

  /// The description of the onboarding page.
  final String description;

  /// The path of the lottie animation.
  final String lottiePath;
}
