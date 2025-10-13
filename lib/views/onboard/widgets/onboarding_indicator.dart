part of '../onboard_view.dart';

final String _previousText = LocaleKeys.generic_previous.tr();
final String _nextText = LocaleKeys.generic_next.tr();
final String _doneText = LocaleKeys.generic_done.tr();

/// A widget that displays a smooth page indicator with next and previous buttons.
///
/// [pageController] is the controller of the page view.
/// [isLastPage] is a flag that indicates whether the page view is on the last page.
/// [onNext] is the callback that is called when the next button is pressed.
/// [onPrevious] is the callback that is called when the previous button is pressed.
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
          child: Text(_previousText),
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
          child: Text(isLastPage ? _doneText : _nextText),
        ),
      ],
    );
  }
}
