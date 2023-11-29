import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:morimori/pages/terms_screen.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';

class EmailNicknameScreen extends StatefulWidget {
  const EmailNicknameScreen({super.key});

  @override
  State<EmailNicknameScreen> createState() => _EmailNicknameScreenState();
}

class _EmailNicknameScreenState extends State<EmailNicknameScreen> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController nicknameTextController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    emailTextController.dispose();
    nicknameTextController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
       appBar: AppBar(
        leading: const BackButton(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Text(
                        'Register Process',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 40,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('email'),
                        SizedBox(height: 20,),
                        TextField(
                          controller: emailTextController,
                        ),
                        SizedBox(height: 20,),
                        Text('nickname'),
                        SizedBox(height: 20,),
                        TextField(
                          controller: nicknameTextController,
                        ),
                        Text('이용약관'),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed:  () {
                    Provider.of<UserModel>(context, listen: false).inputEmail(emailTextController.text);
                    Provider.of<UserModel>(context, listen: false).inputNickname(nicknameTextController.text);
                    Provider.of<UserModel>(context, listen: false).inputAddress();
                    Provider.of<UserModel>(context, listen: false).printData();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ListenableProvider<UserModel>.value(
                            value: Provider.of<UserModel>(context),
                            child: const TermsScreen(),
                    )));
                  },
                  child: const Text('Next'),
                ),
              ),
            ],
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () async {
        //
        //     List<String> networkIdx = List.filled(3, '0', growable: false);
        //     const storage = FlutterSecureStorage();
        //
        //     networkIdx[0] = storage.read(key: 'address').toString();
        //     networkIdx[1] = emailTextController.text;
        //     networkIdx[2] = nicknameTextController.text;
        //     String result = await isUserRegisterd(networkIdx);
        //     print(result);
        //     if(result == "User registered") {
        //       Navigator.pop(context);
        //       Navigator.push(context, MaterialPageRoute(builder: (context) => const MainPage()));
        //     } else if (result == "Wallet address already registered") {
        //       ShowSnackBar.buildSnackbar(
        //           context, "Wallet address already registered");
        //       Navigator.push(context, MaterialPageRoute(builder: (context) => const MainPage()));
        //     } else if (result == "Internal server error") {
        //       ShowSnackBar.buildSnackbar(
        //           context, "Internal server error");
        //     } else {
        //       ShowSnackBar.buildSnackbar(
        //           context, "Server Error");
        //     }
        //   },
        //   child: const Icon(Icons.navigate_next),
        // ),
      ),
    );
  }
}
