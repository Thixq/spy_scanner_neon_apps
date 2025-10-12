part of 'scan_card.dart';

final class ScanCardModel {
  ScanCardModel({
    required this.contentTitle,
    required this.icon,
    this.contentSubTitle,
  });

  final String contentTitle;
  final String? contentSubTitle;
  final IconData icon;
}
