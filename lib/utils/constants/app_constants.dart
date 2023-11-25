/// `AppConstants` 클래스는 애플리케이션 전반에 걸쳐 사용되는
/// 상수 문자열을 정의합니다.
class AppConstants {
  // "초기화 중" 상태를 나타내는 문자열입니다.
  static const String initializing = "Initializing";

  // "초기화 완료" 상태를 나타내는 문자열입니다.
  static const String initialized = "Initialized";

  // "MetaMask가 설치되지 않음" 오류를 나타내는 문자열입니다.
  static const String metamaskNotInstalled = "MetaMask not initialized";

  // "연결 성공" 상태를 나타내는 문자열입니다.
  static const String connectionSuccessful = "Connection Successful";

  // "인증 중, 기다려 주세요" 메시지를 나타내는 문자열입니다.
  static const String authenticatingPleaseWait = "Authenticating Please Wait!";

  // "사용자가 메시지 서명을 거부함" 오류를 나타내는 문자열입니다.
  static const String userDeniedMessageSignature =
      "User denied message signature";

  // "사용자가 연결 요청을 거부함" 오류를 나타내는 문자열입니다.
  static const String userDeniedConnectionRequest =
      "User denied connection request";

  // "지갑 연결 오류" 메시지를 나타내는 문자열입니다.
  static const String walletConnectError =
      "Error to connecting the wallet, please try again letter";

  // "MetaMask 로그인"을 나타내는 문자열입니다.
  static const String metamaskLogin = "MetaMask Login";

  // "인증 성공" 상태를 나타내는 문자열입니다.
  static const String authenticationSuccessful = "Authentication Successful!";
}
