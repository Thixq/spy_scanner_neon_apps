part of '../onboard_view.dart';

class _OnboardingIndicator extends StatelessWidget {
  const _OnboardingIndicator({
    required this.pageController,
    required this.isLastPage,
    required this.onNext,
    required this.onPrevious,
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
