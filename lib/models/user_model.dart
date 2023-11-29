import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserModel extends ChangeNotifier {
  String? _address;
  String? _email;
  String? _nickname;
  int? _userId;
  String? _createdAt;
  String? _updatedAt;
  bool _isLogined = false;

  get address => _address;
  get email => _email;
  get nickname => _nickname;
  get userId => _userId;
  get createdAt => _createdAt;
  get updatedAt => _updatedAt;
  get isLogined => _isLogined;

  inputAddress() async {
    const storage = FlutterSecureStorage();
    _address = await storage.read(key: 'address') ?? '';
    if (kDebugMode) {
      print('getAddress : $_address');
    }
    notifyListeners();
  }

  inputAddressFromServer(String address) {
    _address = address;
    notifyListeners();
  }

  inputUserInfoFromServer(UserData data) {
    _address = data.walletAddress;
    _email = data.email;
    _nickname = data.username;
    _userId = data._userId;
    _createdAt = data.createdAt;
    _updatedAt = data._updatedAt;
    _isLogined = true;
  }

  inputEmail(String email) {
    _email = email;
    if (kDebugMode) {
      print('_email : $_email');
    }
    notifyListeners();
  }

  inputNickname(String nickname) {
    _nickname = nickname;
    if (kDebugMode) {
      print('_nickname : $_nickname');
    }
    notifyListeners();
  }

  updateAddress(String input) {
    _address = input;
    if (kDebugMode) {
      print('_address : $_address');
    }
    notifyListeners();
  }

  printData() {
    if (kDebugMode) {
      print("_address : $_address, _nickname : $_nickname, _email : $_email, _userId : $_userId, _createdAt : $_createdAt, _updatedAt : $_updatedAt");
    }
  }
}

class UserData {
  int? _userId;
  String? _walletAddress;
  String? _email;
  String? _username;
  String? _createdAt;
  String? _updatedAt;

  UserData(
      {int? userId,
        String? walletAddress,
        String? email,
        String? username,
        String? createdAt,
        String? updatedAt}) {
    if (userId != null) {
      _userId = userId;
    }
    if (walletAddress != null) {
      _walletAddress = walletAddress;
    }
    if (email != null) {
      _email = email;
    }
    if (username != null) {
      _username = username;
    }
    if (createdAt != null) {
      _createdAt = createdAt;
    }
    if (updatedAt != null) {
      _updatedAt = updatedAt;
    }
  }

  int? get userId => _userId;
  set userId(int? userId) => _userId = userId;
  String? get walletAddress => _walletAddress;
  set walletAddress(String? walletAddress) => _walletAddress = walletAddress;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get username => _username;
  set username(String? username) => _username = username;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;

  UserData.fromJson(Map<String, dynamic> json) {
    _userId = json['user_id'];
    _walletAddress = json['walletAddress'];
    _email = json['email'];
    _username = json['username'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this._userId;
    data['walletAddress'] = this._walletAddress;
    data['email'] = this._email;
    data['username'] = this._username;
    data['createdAt'] = this._createdAt;
    data['updatedAt'] = this._updatedAt;
    return data;
  }
}