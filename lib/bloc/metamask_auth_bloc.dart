import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/bloc/wallet_event.dart';
import '/utils/constants/app_constants.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/session_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/sign_client_models.dart';
import 'package:walletconnect_flutter_v2/apis/utils/namespace_utils.dart';

import '../services/services.dart';
import 'wallet_state.dart';

// MetaMask 인증을 처리하는 BLoC 클래스
class MetaMaskAuthBloc extends Bloc<WalletEvent, WalletState> {
  MetaMaskAuthBloc() : super(WalletInitialState()) {
    // 메타마스크 인증을 처리하는 이벤트 리스너
    on<MetamaskAuthEvent>((event, emit) async {
      // 초기화 상태 발생
      emit(WalletInitializedState(message: AppConstants.initializing));
      // WalletConnect를 사용하여 메타마스크 초기화
      bool isInitialize = await walletConnectorService.initialize();
      if (isInitialize) {
        // 초기화 성공 상태 발생
        emit(WalletInitializedState(message: AppConstants.initialized));
        // 메타마스크와 연결 시도
        ConnectResponse? resp = await walletConnectorService
            .connect(); // 메타마스크와 연결

        if (resp != null) {
          // 메타마스크 URI 얻기
          Uri? uri = resp.uri;
          if (uri != null) {
            // 메타마스크 앱으로 리다이렉트 하기
            bool canLaunch = await walletConnectorService.onDisplayUri(uri);
            if (!canLaunch) {
              // 메타마스크 앱 설치되지 않은 경우 처리
              emit(WalletErrorState(message: AppConstants.metamaskNotInstalled));
            } else {
              // 메타마스크에서 인증 요청
              SessionData?
              sessionData = await walletConnectorService.authorize(
                  resp, event.signatureFromBackend);
              if (sessionData != null) {
                // 인증 성공 상태 발생
                emit(WalletAuthorizedState(
                    message: AppConstants.connectionSuccessful));
                if (resp.session.isCompleted) {
                  // 지갑 주소 추출
                  final String walletAddress = NamespaceUtils.getAccount(
                    sessionData.namespaces.values.first.accounts.first,
                  );
                  debugPrint("WALLET ADDRESS - $walletAddress");
                  // 메타마스크 앱으로 다시 리다이렉트
                  bool canLaunch =
                  await walletConnectorService.onDisplayUri(uri);
                  if (!canLaunch) {
                    // 메타마스크 앱 설치되지 않은 경우 처리
                    emit(WalletErrorState(
                        message: AppConstants.metamaskNotInstalled));
                  } else {
                    // 메타마스크로 서명 요청
                    final signatureFromWallet =
                    await walletConnectorService.sendMessageForSigned(
                        resp,
                        walletAddress,
                        sessionData.topic,
                        event.signatureFromBackend);
                    if (signatureFromWallet != null &&
                        signatureFromWallet != "") {
                      // 서명 수신 성공 상태 발생
                      emit(WalletReceivedSignatureState(
                          signatureFromWallet: signatureFromWallet,
                          signatureFromBk: event.signatureFromBackend,
                          walletAddress: walletAddress,
                          message: AppConstants.authenticatingPleaseWait));
                    } else {
                      // 서명 요청 거부 처리
                      emit(WalletErrorState(
                          message: AppConstants.userDeniedMessageSignature));
                    }
                    // 지갑 연결 해제
                    walletConnectorService.disconnectWallet(
                        topic: sessionData.topic);
                  }
                }
              } else {
                // 연결 요청 취소 처리
                emit(WalletErrorState(
                    message: AppConstants.userDeniedConnectionRequest));
              }
            }
          }
        }
      } else {
        // WalletConnect 오류 처리
        emit(WalletErrorState(message: AppConstants.walletConnectError));
      }
    });
  }
}
