import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class User extends ChangeNotifier {
  String? _address;

  get address => _address;

  void getAddress() async {
    const storage = FlutterSecureStorage();
    _address = storage.read(key: 'address').toString();
    print('getAddress : $_address');
    notifyListeners();
  }

  void updateAddress(String input) {
    _address = input;
    notifyListeners();
  }
}