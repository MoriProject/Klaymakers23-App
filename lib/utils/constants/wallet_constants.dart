import '../../models/chain_metadata.dart';

/// `WalletConstants` 클래스는 지갑 연결 및 블록체인 관련 상수를 정의합니다.
class WalletConstants {
  // 메인 블록체인에 대한 메타데이터를 정의합니다. 여기서는 이더리움 네트워크를 예로 들었습니다.
  static const mainChainMetaData = ChainMetadata(
    type: "eip155", // EIP-155 체인 타입을 나타냅니다.
    chainId: 'eip155:1', // 이더리움 메인넷의 체인 ID입니다.
    name: 'Ethereum', // 블록체인의 이름입니다.
    method: "personal_sign", // 사용되는 서명 메소드입니다.
    events: ["chainChanged", "accountsChanged"], // 지갑 이벤트들의 목록입니다.
    relayUrl: "wss://relay.walletconnect.com", // WalletConnect 릴레이 서버 URL입니다.
    projectId: "68ccdce69aec001e3cd0b33aec530b81", // 프로젝트 ID입니다.
    redirectUrl: "metamask://com.example.metamask_login_blog", // 리다이렉트 URL입니다.
    walletConnectUrl: "https://walletconnect.com", // WalletConnect URL입니다.
  );

  // MetaMask 딥링크 접두사를 정의합니다. 이는 WalletConnect URI와 결합하여 사용됩니다.
  static const deepLinkMetamask = "metamask://wc?uri=";
}
