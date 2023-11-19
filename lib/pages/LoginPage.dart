import 'package:flutter/material.dart';
import 'package:morimori/pages/MainPage.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/session_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/sign_client_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/sign_client.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              //로고
              Image.asset(
                'assets/morilogo.png',
                width: 170,
              ),
              const SizedBox(
                height: 30,
              ),
              //Sign in with your wallet
              const Text(
                'Sign in with your wallet',
                style: TextStyle(
                    color: Colors.black,
                    height: 1.4,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'NanumSquareRegular'),
              ),
              const SizedBox(
                height: 16,
              ),
              //Sign in using one of the available..
              Flexible(
                child: RichText(
                  overflow: TextOverflow.clip,
                  maxLines: 5,
                  text: const TextSpan(
                    style: TextStyle(
                        color: Colors.black,
                        height: 1.4,
                        fontSize: 14.0,
                        fontFamily: 'NanumSquareRegular'),
                    text:
                        'Sign in using one of the available wallet providers, or create a new wallet',
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              //metamask 로그인 버튼
              GestureDetector(
                onTap: () {
                  print('metamask login button clicked');
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(90)),
                    border: Border.all(color: Colors.black45),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Image.asset('assets/metamasklogo.png'),
                      const SizedBox(
                        width: 20,
                      ),
                      const Text('Sign in with MetaMask'),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              //WalletConnect 로그인 버튼
              Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(90)),
                  border: Border.all(color: Colors.black45),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Image.asset('assets/connectwalletlogo.png'),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text('Sign in with WalletConnect'),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              //We do not own your private keys and cannot access your assets without your confirmation.
              Flexible(
                child: RichText(
                  overflow: TextOverflow.clip,
                  maxLines: 5,
                  text: const TextSpan(
                    style: TextStyle(
                        color: Colors.black,
                        height: 1.4,
                        fontSize: 12.0,
                        fontFamily: 'NanumSquareRegular'),
                    text:
                        'We do not own your private keys and cannot access your assets without your confirmation.',
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainPage()));
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'I will sign in later',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Icon(Icons.arrow_forward_ios_rounded, size: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
