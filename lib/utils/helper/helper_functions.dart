/// 주어진 딥링크(deepLink)와 WalletConnect URI(wcUri)를 사용하여
/// 네이티브 URL 형식을 생성하고 반환합니다.
///
/// [deepLink]는 앱의 딥링크 스키마를 나타내며, null일 수 있습니다.
/// [wcUri]는 WalletConnect URI를 나타냅니다.
///
/// 반환되는 `Uri`는 네이티브 앱에서 사용할 수 있는 형식으로 조정됩니다.
Uri? formatNativeUrl(String? deepLink, String wcUri) {
  // 안전한 앱 URL을 초기화합니다. deepLink가 null이면 빈 문자열로 설정합니다.
  String safeAppUrl = deepLink ?? "";

  // deepLink가 null이 아니고 비어있지 않은 경우, URL 형식을 확인하고 조정합니다.
  if (deepLink != null && deepLink.isNotEmpty) {
    // '://'가 포함되어 있지 않으면, 이를 추가합니다.
    if (!safeAppUrl.contains('://')) {
      safeAppUrl = deepLink.replaceAll('/', '').replaceAll(':', '');
      safeAppUrl = '$safeAppUrl://';
    }
  }

  // WalletConnect URI를 인코딩합니다.
  String encodedWcUrl = Uri.encodeComponent(wcUri);

  // 안전한 앱 URL과 인코딩된 WalletConnect URI를 결합하여 Uri 객체를 생성합니다.
  return Uri.parse('$safeAppUrl$encodedWcUrl');
}
