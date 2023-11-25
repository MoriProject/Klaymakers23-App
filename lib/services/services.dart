import 'package:get_it/get_it.dart';

import 'metamask/metamask_connector_impl.dart';
import 'metamask/wallet_connector_service.dart';

// GetIt 인스턴스를 생성합니다. GetIt는 서비스 로케이터 패턴을 구현한 의존성 주입 라이브러리입니다.
final getIt = GetIt.instance;

/// 애플리케이션에서 사용할 서비스들을 초기화하고 GetIt에 등록하는 함수입니다.
initServices() {
  // WalletConnectorService 인터페이스에 대한 구현체로 MetamaskConnectorImpl를 등록합니다.
  getIt.registerSingleton<WalletConnectorService>(MetamaskConnectorImpl());
}

/// 등록된 WalletConnectorService 인스턴스를 반환하는 getter입니다.
WalletConnectorService get walletConnectorService => getIt.get();
