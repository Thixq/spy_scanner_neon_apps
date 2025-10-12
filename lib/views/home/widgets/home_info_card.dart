part of '../home_view.dart';

class _HomeInfoCard extends StatelessWidget {
  const _HomeInfoCard();

  @override
  Widget build(BuildContext context) {
    return const InfoCard(
      title: 'Security Camera',
      subTitle:
          'Camera is not responding. Check the camera connection and try again.',
    );
  }
}
