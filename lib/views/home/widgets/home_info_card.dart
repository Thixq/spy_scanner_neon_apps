part of '../home_view.dart';

class _HomeInfoCard extends StatelessWidget {
  const _HomeInfoCard();

  @override
  Widget build(BuildContext context) {
    return const InfoCard(
      title: 'Security Camera',
      subTitle:
          'Always check your room for hidden cameras. Inspect smoke detectors, alarm clocks, mirrors, and power outlets. Protect your privacy — report any suspicious devices to hotel staff immediately. Stay safe and aware.',
    );
  }
}
