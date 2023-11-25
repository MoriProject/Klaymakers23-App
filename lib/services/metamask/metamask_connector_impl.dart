import 'package:flutter/material.dart';
import '/services/metamask/wallet_connector_service.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/utils/pairing_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/json_rpc_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/proposal_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/session_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/sign_client_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/sign_client.dart';
import 'package:walletconnect_flutter_v2/apis/utils/errors.dart';

import '../../models/chain_metadata.dart';
import '../../utils/constants/wallet_constants.dart';
import '../../utils/helper/helper_functions.dart';

/// MetaMask와의 연결 및 상호작용을 위한 서비스를 구현하는 클래스입니다.
class MetamaskConnectorImpl implements WalletConnectorService {
  late SignClient _wcClient; // WalletConnect 클라이언트 인스턴스입니다.
  final ChainMetadata _chainMetadata = WalletConstants.mainChainMetaData; // 체인 메타데이터입니다.

  @override
  SignClient get wClient => _wcClient; // WalletConnect 클라이언트 getter입니다.

  @override
  Future<bool> initialize() async {
    bool isInitialize = false;
    try {
      // SignClient 인스턴스를 생성합니다.
      _wcClient = await SignClient.createInstance(
        relayUrl: _chainMetadata.relayUrl, // 릴레이 서버 URL입니다.
        projectId: _chainMetadata.projectId, // 프로젝트 ID입니다.
        metadata: PairingMetadata(
            name: "MetaMask", // 메타데이터 이름입니다.
            description: "MetaMask login", // 메타데이터 설명입니다.
            url: _chainMetadata.walletConnectUrl, // WalletConnect URL입니다.
            icons: ["https://wagmi.sh/icon.png"], // 아이콘 URL입니다.
            redirect: Redirect(universal: _chainMetadata.redirectUrl)), // 리다이렉트 URL입니다.
      );
      isInitialize = true;
    } catch (err) {
      debugPrint("Catch wallet initialize error $err"); // 초기화 오류를 출력합니다.
    }
    return isInitialize;
  }

  @override
  Future<ConnectResponse?> connect() async {
    try {
      // WalletConnect 클라이언트를 통해 연결을 시도합니다.
      ConnectResponse? resp = await wClient.connect(requiredNamespaces: {
        _chainMetadata.type: RequiredNamespace(
          chains: [_chainMetadata.chainId], // 이더리움 체인 ID입니다.
          methods: [_chainMetadata.method], // 요청 가능한 메소드들입니다.
          events: _chainMetadata.events, // 요청 가능한 이벤트들입니다.
        )
      });

      return resp;
    } catch (err) {
      debugPrint("Catch wallet connect error $err"); // 연결 오류를 출력합니다.
    }
    return null;
  }

  @override
  Future<SessionData?> authorize(
      ConnectResponse resp, String unSignedMessage) async {
    SessionData? sessionData;
    try {
      // 세션 데이터를 가져옵니다.
      sessionData = await resp.session.future;
    } catch (err) {
      debugPrint("Catch wallet authorize error $err"); // 인증 오류를 출력합니다.
    }
    return sessionData;
  }

  @override
  Future<String?> sendMessageForSigned(ConnectResponse resp,
      String walletAddress, String topic, String unSignedMessage) async {
    String? signature;
    try {
      Uri? uri = resp.uri;
      if (uri != null) {
        // 세션이 확립되면 서명 요청을 보냅니다.
        final res = await wClient.request(
          topic: topic, // 토픽입니다.
          chainId: _chainMetadata.chainId, // 체인 ID입니다.
          request: SessionRequestParams(
            method: _chainMetadata.method, // 사용할 메소드입니다.
            params: [unSignedMessage, walletAddress], // 파라미터들입니다.
          ),
        );
        signature = res.toString();
      }
    } catch (err) {
      debugPrint("Catch SendMessageForSigned error $err"); // 서명 요청 오류를 출력합니다.
    }
    return signature;
  }

  @override
  Future<bool> onDisplayUri(Uri? uri) async {
    // 딥링크를 통해 URL을 생성하고, 이를 실행합니다.
    final link =
    formatNativeUrl(WalletConstants.deepLinkMetamask, uri.toString());
    var url = link.toString();
    if (!await canLaunchUrlString(url)) {
      return false;
    }
    return await launchUrlString(url, mode: LaunchMode.externalApplication);
  }

  @override
  Future<void> disconnectWallet({required String topic}) async {
    // 지갑 연결을 해제합니다.
    await wClient.disconnect(
        topic: topic, reason: Errors.getSdkError(Errors.USER_DISCONNECTED));
  }
}

