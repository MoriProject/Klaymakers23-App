import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../ui/features/widgets/custom/show_snack_bar.dart';
import 'MainPage.dart';

import 'package:http/http.dart' as http;


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
                    ? () async {
                  var provider = Provider.of<UserModel>(context, listen: false);
                      List<String> networkIdx = List.filled(3, '0', growable: false);
                      const storage = FlutterSecureStorage();

                      networkIdx[0] = (await storage.read(key: 'address'))!;
                      networkIdx[1] = provider.email;
                      networkIdx[2] = provider.nickname;
                      String result = await postUserRegisterd(networkIdx);
                      print(result);
                      if(result == "User registered") {
                        Navigator.pop(context);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainPage()));
                      } else if (result == "Wallet address already registered") {
                        ShowSnackBar.buildSnackbar(
                            context, "Wallet address already registered");
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainPage()));
                      } else if (result == "Internal server error") {
                        ShowSnackBar.buildSnackbar(
                            context, "Internal server error");
                      } else {
                        ShowSnackBar.buildSnackbar(
                            context, "Server Error");
                      }

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ListenableProvider<UserModel>.value(
                            value: Provider.of<UserModel>(context),
                            child: const MainPage(),
                          )));
                }
                    : null,
                child: const Text('Next'),
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Provider.of<User>(context, listen: false).inputAddress();
      //     print(Provider.of<User>(context, listen: false).address);
      //   },
      // ),
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

Future<String> postUserRegisterd(List<String> index) async {
  http.Response response = await http.post(
      Uri.parse('https://nftmori.shop/api/users/register'),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: <String, dynamic>{
        'walletAddress': index[0],
        'email': index[1],
        'username': index[2],
      }
  );
  //print(response.body);
  return response.body;
}