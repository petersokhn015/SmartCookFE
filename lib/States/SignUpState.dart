import 'package:flutter/material.dart';

class SignUpState extends ChangeNotifier {
  bool _isPasswordSixCharacters = false;
  bool _hasPasswordOneNumber = false;
  bool _isPasswordOneUpper = false;
  bool _hasPasswordOneLower = false;
  bool _hasPasswordOneSpecial = false;
  bool _isEmailValid = false;
  bool _isUsernameValid = false;
  bool _isEmailEmpty = true;
  bool _isPasswordEmpty = true;
  bool _isUsernameEmpty = true;

  void initialize() {
    _isPasswordSixCharacters = false;
    _hasPasswordOneNumber = false;
    _isPasswordOneUpper = false;
    _hasPasswordOneLower = false;
    _hasPasswordOneSpecial = false;
    _isEmailValid = false;
    _isUsernameValid = false;
    notifyListeners();
  }

  bool get isPasswordSixCharacters => _isPasswordSixCharacters;
  bool get hasPasswordOneNumber => _hasPasswordOneNumber;
  bool get isPasswordOneUpper => _isPasswordOneUpper;
  bool get hasPasswordOneLower => _hasPasswordOneLower;
  bool get hasPasswordOneSpecial => _hasPasswordOneSpecial;
  bool get isEmailValid => _isEmailValid;
  bool get isUsernameValid => _isUsernameValid;
  bool get isEmailEmpty => _isEmailEmpty;
  bool get isPasswordEmpty => _isPasswordEmpty;
  bool get isUsernameEmpty => _isUsernameEmpty;

  void setIsPasswordEmpty(String password){
    if(password.isNotEmpty){
      _isPasswordEmpty = false;
    }
    _isPasswordEmpty = true;
    notifyListeners();
  }

  void setIsEmailEmpty(String email){
    if(email.isNotEmpty){
      _isEmailEmpty = false;
    }
    _isEmailEmpty = true;
    notifyListeners();
  }

  void setIsUsernameEmpty(String username){
    if(username.isNotEmpty){
      _isUsernameEmpty = false;
    }
    _isUsernameEmpty = true;
    notifyListeners();
  }

  onPasswordChanged(String password) {
    final numericRegex = RegExp(r'[0-9]');
    final uppercaseRegex = RegExp(r'[A-Z]');
    final lowercaseRegex = RegExp(r'[a-z]');
    final specialCharacterRegex = RegExp(r'[!@#\$%^&*(),.?":{}|<>]');

    _isPasswordSixCharacters = password.length >= 6;
    _hasPasswordOneNumber = numericRegex.hasMatch(password);
    _isPasswordOneUpper = uppercaseRegex.hasMatch(password);
    _hasPasswordOneLower = lowercaseRegex.hasMatch(password);
    _hasPasswordOneSpecial = specialCharacterRegex.hasMatch(password);

    if(password.isNotEmpty){
      _isPasswordEmpty = false;
    }
    notifyListeners();
  }

  onEmailChanged(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    _isEmailValid = emailRegex.hasMatch(email);
    if(email.isNotEmpty){
      _isEmailEmpty = false;
    }

    notifyListeners();
  }

  onUsernameChanged(String username) {
    bool isValid = false;
    if (username.isNotEmpty) {
      isValid = true;
      _isUsernameEmpty = false;
    }
    _isUsernameValid = isValid;
    notifyListeners();
  }
}
