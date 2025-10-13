import 'package:flutter/material.dart';

class MutliTextLine extends StatelessWidget {
  const MutliTextLine({
    required this.lines,
    super.key,
    this.style,
    this.spacing = 0.0,
  });
  final List<String> lines;
  final TextStyle? style;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: spacing,
      children: lines
          .map(
            (e) => Text(
              e,
              style: style,
            ),
          )
          .toList(),
    );
  }
}
