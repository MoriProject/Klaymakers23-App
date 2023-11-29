import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class User extends ChangeNotifier {
  String? _address;
  String? _email;
  String? _nickname;

  get address => _address;
  get email => _email;
  get nickname => _nickname;

  inputAddress() async {
    const storage = FlutterSecureStorage();
    _address = await storage.read(key: 'address') ?? '';
    print('getAddress : $_address');
    notifyListeners();
  }

  inputEmail(String email) {
    _email = email;
    print('_email : $_email');
    notifyListeners();
  }

  inputNickname(String nickname) {
    _nickname = nickname;
    print('_nickname : $_nickname');
    notifyListeners();
  }

  void updateAddress(String input) {
    _address = input ?? '';
    print('_address : $_address');
    notifyListeners();
  }
}