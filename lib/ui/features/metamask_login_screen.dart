import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morimori/bloc/metamask_auth_bloc.dart';
import 'package:morimori/bloc/wallet_state.dart';
import 'package:morimori/ui/features/widgets/custom/other_custom_widgets.dart';
import 'package:morimori/ui/features/widgets/custom/show_snack_bar.dart';
import 'package:morimori/utils/constants/app_constants.dart';
import 'package:morimori/utils/constants/assets.dart';

import '../../bloc/wallet_event.dart';
import 'widgets/custom/nsalert_dialog.dart';

// MetaMask 로그인 화면을 관리하는 StatefulWidget 클래스
class MetaMaskLoginScreen extends StatefulWidget {
  const MetaMaskLoginScreen({super.key});

  @override
  State<MetaMaskLoginScreen> createState() => _MetaMaskLoginScreenState();
}

class _MetaMaskLoginScreenState extends State<MetaMaskLoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  BuildContext? dialogContext;
  final String signatureFromBackend = "NonStop IO Technologies Pvt Ltd.";

  @override
  Widget build(BuildContext context) {
    return BlocListener<MetaMaskAuthBloc, WalletState>(
      // BLoC 상태에 따른 리스너 설정
      listener: (context, state) {
        if (state is WalletErrorState) {
          // 오류 상태 처리
          hideDialog(dialogContext);
          ShowSnackBar.buildSnackbar(context, state.message, true);
        } else if (state is WalletReceivedSignatureState) {
          // 서명 수신 성공 처리
          hideDialog(dialogContext);
          ShowSnackBar.buildSnackbar(
              context, AppConstants.authenticationSuccessful);
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: Center(
            child: InkWell(
              onTap: () {
                // MetaMask 인증 이벤트 발생
                BlocProvider.of<MetaMaskAuthBloc>(context).add(
                  MetamaskAuthEvent(signatureFromBackend: signatureFromBackend),
                );
                buildShowDialog(context);
              },
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        Assets.metamaskIcon,
                        height: 40,
                        width: 40,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        AppConstants.metamaskLogin,
                      )
                    ],
                  ),
                ),
              ),
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
