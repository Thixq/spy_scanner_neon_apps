import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spy_scanner/feature/localization/localization_codegen/locale_keys.g.dart';

final String _title = LocaleKeys.dialogs_feedback_dialog_title.tr();
final String _description = LocaleKeys.dialogs_feedback_dialog_description.tr();
final String _cancelText = LocaleKeys.dialogs_feedback_dialog_cancel_text.tr();
final String _sendText = LocaleKeys.dialogs_feedback_dialog_send_text.tr();

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
      title: Text(_title),
      content: TextField(
        maxLines: 3,
        decoration: InputDecoration(hintText: _description),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(_cancelText),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(_sendText),
        ),
      ],
    );
  }
}
