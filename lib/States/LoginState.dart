//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginState extends ChangeNotifier{
  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //
  // User? get currentUser => _firebaseAuth.currentUser;
  // Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
  // bool? isLoggedInViaGoogle;
  // final googleSignIn = GoogleSignIn();
  // final Future<SharedPreferences> _preferences =
  // SharedPreferences.getInstance();
  //
  // GoogleSignInAccount? _googleSignInUser;
  // GoogleSignInAccount get user => _googleSignInUser!;

  bool _isPasswordSixCharacters = false;
  bool _hasPasswordOneNumber = false;
  bool _isPasswordOneUpper = false;
  bool _hasPasswordOneLower = false;
  bool _hasPasswordOneSpecial = false;
  bool _isEmailValid = false;
  bool _isEmailEmpty = true;
  bool _isPasswordEmpty = true;

  bool get isPasswordSixCharacters => _isPasswordSixCharacters;
  bool get hasPasswordOneNumber => _hasPasswordOneNumber;
  bool get isPasswordOneUpper => _isPasswordOneUpper;
  bool get hasPasswordOneLower => _hasPasswordOneLower;
  bool get hasPasswordOneSpecial => _hasPasswordOneSpecial;
  bool get isEmailValid => _isEmailValid;
  bool get isEmailEmpty => _isEmailEmpty;
  bool get isPasswordEmpty => _isPasswordEmpty;

  void initialize() {
    _isPasswordSixCharacters = false;
    _hasPasswordOneNumber = false;
    _isPasswordOneUpper = false;
    _hasPasswordOneLower = false;
    _hasPasswordOneSpecial = false;
    _isEmailValid = false;
    notifyListeners();
  }

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



  // Future<void> googleLogin() async {
  //   try {
  //     final SharedPreferences preferences = await _preferences;
  //     final googleUser = await googleSignIn.signIn();
  //     if (googleUser == null) return;
  //
  //     _googleSignInUser = googleUser;
  //
  //     final googleAuth = await googleUser.authentication;
  //     preferences.setBool("isLoggedInViaGoogle", true);
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );
  //
  //     await FirebaseAuth.instance.signInWithCredential(credential);
  //     notifyListeners();
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }
  //
  // Future<void> signOut() async {
  //   final SharedPreferences preferences = await _preferences;
  //   await _firebaseAuth.signOut();
  //   if (preferences.getBool("isLoggedInViaGoogle") == true) {
  //     await googleSignIn.disconnect();
  //     await googleSignIn.signOut();
  //     preferences.setBool("isLoggedInViaGoogle", false);
  //     notifyListeners();
  //   }
  // }
}