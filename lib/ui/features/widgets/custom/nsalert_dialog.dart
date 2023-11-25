import 'package:flutter/material.dart';

import 'other_custom_widgets.dart';

class NSAlertDialog extends StatelessWidget {
  final Widget textWidget;
  const NSAlertDialog({super.key, required this.textWidget});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      backgroundColor: Colors.green,
      content: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            setCustomProgressBar(context),
            const SizedBox(
              height: 20,
            ),
            textWidget
          ],
        ),
      ),
    );
  }
}
