import 'dart:async';

import 'package:flutter/material.dart';

class FeedbackDialog extends StatelessWidget {
  const FeedbackDialog({super.key});

  static void show(
    BuildContext context,
  ) {
    unawaited(
      showAdaptiveDialog(
        context: context,
        builder: (context) {
          return const FeedbackDialog();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Feedback'),
      content: const TextField(
        maxLines: 3,
        decoration: InputDecoration(hintText: 'Enter your feedback'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Send'),
        ),
      ],
    );
  }
}
