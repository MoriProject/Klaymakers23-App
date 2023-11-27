import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morimori/pages/MainPage.dart';
import 'package:morimori/bloc/metamask_auth_bloc.dart';
import 'package:morimori/bloc/wallet_state.dart';
import 'package:morimori/pages/terms_screen.dart';
import 'package:morimori/ui/features/widgets/custom/other_custom_widgets.dart';
import 'package:morimori/ui/features/widgets/custom/show_snack_bar.dart';
import 'package:morimori/utils/constants/app_constants.dart';

import '../../bloc/wallet_event.dart';
import 'package:morimori/ui/features/widgets/custom/nsalert_dialog.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  BuildContext? dialogContext;
  final String signatureFromBackend = "We are Mori";

  @override
  Widget build(BuildContext context) {
    return BlocListener<MetaMaskAuthBloc, WalletState>(
      // BLoC 상태에 따른 리스너 설정
      listener: (context, state) {
        if (state is WalletErrorState) {
          print('오류 상태');
          // 오류 상태 처리
          hideDialog(dialogContext);
          ShowSnackBar.buildSnackbar(context, state.message, true);
        } else if (state is WalletReceivedSignatureState) {
          print('서명 수신 성공');
          // 서명 수신 성공 처리
          hideDialog(dialogContext);
          ShowSnackBar.buildSnackbar(
              context, AppConstants.authenticationSuccessful);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext context) {
                return const TermsScreen();
              }));
        }
      },
      child: Scaffold(
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
                ///metamask 로그인 버튼
                GestureDetector(
                  onTap: () {
                    print('metamask login button clicked');
                    // MetaMask 인증 이벤트 발생
                    BlocProvider.of<MetaMaskAuthBloc>(context).add(
                      MetamaskAuthEvent(signatureFromBackend: signatureFromBackend),
                    );
                    buildShowDialog(context);
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
      ),
    );
  }
  // 대화 상자를 표시하는 함수
  buildShowDialog(BuildContext context) {
    return showDialog(
        context: _scaffoldKey.currentContext ?? context,
        barrierDismissible: true, // 대화 상자가 해제 가능한지 설정
        builder: (BuildContext dialogContextL) {
          dialogContext = dialogContextL;
          return BlocBuilder<MetaMaskAuthBloc, WalletState>(
              builder: (context, state) {
                return NSAlertDialog(
                  textWidget: getText(state),
                );
              });
        });
  }
  // 상태에 따라 텍스트를 반환하는 함수
  getText(WalletState state) {
    String message = "";
    if (state is WalletInitializedState) {
      // 초기화 상태 메시지 처리
      message = state.message;
    } else if (state is WalletAuthorizedState) {
      // 인증 상태 메시지 처리
      message = state.message;
    } else if (state is WalletReceivedSignatureState) {
      // 서명 수신 상태 메시지 처리
      message = state.message;
    }
    return Text(
      message,
      style: const TextStyle(fontSize: 18, color: Colors.white),
    );
  }
}