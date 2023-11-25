import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// WalletEvent는 모든 지갑 관련 이벤트의 추상 기본 클래스입니다.
@immutable
abstract class WalletEvent extends Equatable {}

// MetamaskAuthEvent는 MetaMask 인증 요청을 나타내는 이벤트 클래스입니다.
class MetamaskAuthEvent extends WalletEvent {
  // 백엔드로부터 받은 서명을 저장합니다.
  final String signatureFromBackend;

  MetamaskAuthEvent({required this.signatureFromBackend});

  @override
  // Equatable 패키지를 사용하여 객체 비교를 위해 필요한 속성을 정의합니다.
  List<Object?> get props => [signatureFromBackend];
}
