import 'package:flutter/material.dart';

import 'MainPage.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen({super.key});

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  bool _agreedToTerms = false;

  void _setAgreedToTerms(bool newValue) {
    setState(() {
      _agreedToTerms = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(
                  'assets/morilogo.png',
                width: 100,
                height: 100,
              ), // Replace with your asset image
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Your Terms of Use content goes here...', // Replace with your terms content
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
            ),
            CheckboxListTile(
              title: RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(text: 'I '),
                    TextSpan(text: 'agree', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: ' to the '),
                    TextSpan(text: 'Terms of Use', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: ' of this service.'),
                  ],
                ),
              ),
              value: _agreedToTerms,
              onChanged: (bool? value) {
                _setAgreedToTerms(value!);
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _agreedToTerms
                    ? () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                        return const MainPage();
                      }));
                }
                    : null,
                child: const Text('Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       leading: IconButton(
  //         onPressed: () {
  //           Navigator.pop(context);
  //         },
  //         icon: const Icon(Icons.arrow_back_ios_new_outlined),
  //       ),
  //       elevation: 0,
  //     ),
  //     body: const Column(
  //       children: [
  //         SizedBox(height: 20,),
  //
  //       ],
  //     ),
  //   );
  // }
}
