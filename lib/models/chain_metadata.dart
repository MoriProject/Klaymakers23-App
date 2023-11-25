class ChainMetadata {
  // 체인의 고유 식별자입니다. 블록체인 네트워크를 구분하는 데 사용됩니다.
  final String chainId;

  // 체인의 이름입니다.
  final String name;

  // 체인의 타입 또는 종류를 나타냅니다. 예: "공개", "사설" 등.
  final String type;

  // 체인과 상호 작용할 때 사용되는 메소드 또는 프로토콜을 지정합니다.
  final String method;

  // 체인에서 발생할 수 있는 이벤트들의 목록입니다.
  final List<String> events;

  // 체인과의 통신을 중계할 URL입니다.
  final String relayUrl;

  // 체인과 연관된 프로젝트의 ID입니다.
  final String projectId;

  // 사용자가 특정 작업을 수행한 후 리다이렉트될 URL입니다.
  final String redirectUrl;

  // WalletConnect 프로토콜을 통해 체인에 연결하기 위한 URL입니다.
  final String walletConnectUrl;

  // ChainMetadata 클래스의 생성자입니다. 모든 필드는 필수적으로 입력해야 합니다.
  const ChainMetadata({
    required this.chainId,
    required this.name,
    required this.type,
    required this.method,
    required this.events,
    required this.relayUrl,
    required this.projectId,
    required this.redirectUrl,
    required this.walletConnectUrl,
  });
}
