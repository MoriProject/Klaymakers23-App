import 'package:flutter/material.dart';

import '../../../../pages/LoginPage.dart';

void showHackathonLoginDialog(BuildContext context) async {
  showDialog(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Want to host or join a hackathon?'),
      content: RichText(
        text: const TextSpan(
          style: TextStyle(color: Colors.black, fontSize: 16), // 기본 텍스트 색상
          children: <TextSpan>[
            TextSpan(text: 'Sign in with your wallet'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(dialogContext).pop();
          },
        ),
        TextButton(
          child: const Text('Login'),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LoginPage()),
                  (Route<dynamic> route) => false,
            );
          },
        ),
      ],
    ),
  );
}