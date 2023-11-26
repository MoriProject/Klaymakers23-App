import 'package:walletconnect_flutter_v2/apis/sign_api/models/session_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/sign_client_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/sign_client.dart';

/// 지갑 연결과 관련된 서비스의 인터페이스를 정의하는 추상 클래스입니다.
abstract class WalletConnectorService {
  // WalletConnect 클라이언트 인스턴스를 반환합니다.
  SignClient get wClient;

  /// 지갑 연결을 초기화하는 메소드입니다.
  Future<bool> initialize();

  /// 지갑에 연결을 시도하는 메소드입니다.
  Future<ConnectResponse?> connect();

  /// 지갑 인증을 처리하는 메소드입니다.
  Future<SessionData?> authorize(
      ConnectResponse resp,
      String unSignedMessage,
      );

  /// 서명된 메시지를 요청하는 메소드입니다.
  Future<String?> sendMessageForSigned(
      ConnectResponse resp,
      String walletAddress,
      String topic,
      String unSignedMessage,
      );

  /// URI를 표시하기 위한 메소드입니다.
  Future<bool> onDisplayUri(Uri? uri);

  /// 지갑 연결을 해제하는 메소드입니다.
  Future<void> disconnectWallet({required String topic});
}
