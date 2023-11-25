import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// WalletState는 모든 지갑 관련 상태의 추상 기본 클래스입니다.
@immutable
abstract class WalletState extends Equatable {}

// WalletInitialState는 초기 상태를 나타내는 클래스입니다.
class WalletInitialState extends WalletState {
  @override
  List<Object?> get props => [];
}

// WalletInitializedState는 지갑이 초기화된 상태를 나타내는 클래스입니다.
class WalletInitializedState extends WalletState {
  final String message; // 상태 관련 메시지를 저장합니다.
  WalletInitializedState({required this.message});
  @override
  List<Object?> get props => [message];
}

// WalletAuthorizedState는 지갑이 인증된 상태를 나타내는 클래스입니다.
class WalletAuthorizedState extends WalletState {
  final String message; // 인증 관련 메시지를 저장합니다.
  WalletAuthorizedState({required this.message});
  @override
  List<Object?> get props => [message];
}

// WalletReceivedSignatureState는 서명이 수신된 상태를 나타내는 클래스입니다.
class WalletReceivedSignatureState extends WalletState {
  final String message; // 상태 관련 메시지를 저장합니다.
  final String signatureFromWallet; // 지갑으로부터 수신된 서명을 저장합니다.
  final String signatureFromBk; // 백엔드로부터 받은 서명을 저장합니다.
  final String walletAddress; // 지갑 주소를 저장합니다.
  WalletReceivedSignatureState({
    required this.signatureFromWallet,
    required this.signatureFromBk,
    required this.walletAddress,
    required this.message});
  @override
  List<Object?> get props =>
      [signatureFromWallet, signatureFromBk, walletAddress, message];
}

// WalletErrorState는 오류 상태를 나타내는 클래스입니다.
class WalletErrorState extends WalletState {
  final String message; // 오류 메시지를 저장합니다.
  WalletErrorState({required this.message});
  @override
  List<Object?> get props => [message];
}
