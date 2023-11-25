import 'package:flutter/material.dart';

Widget setCustomProgressBar(BuildContext context) {
  return const Align(
    alignment: Alignment.center,
    child: CircularProgressIndicator(
      color: Colors.white,
    ),
  );
}

void hideDialog(BuildContext? dialogContext) {
  try {
    if (dialogContext != null) {
      Navigator.pop(dialogContext);
    }
  } catch (e) {
    debugPrint(e.toString());
  }
}
