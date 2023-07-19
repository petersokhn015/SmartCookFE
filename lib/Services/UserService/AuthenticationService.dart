import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../Utils/strings.dart';

class AuthenticationService {
  Future<bool> register(String username, String email, String password) async {
    bool isRegistered = false;
    final headers = {'Content-Type': 'application/json'};
    final body = json
        .encode({'username': username, 'email': email, 'password': password});
    final response = await http.post(Uri.parse(APIEndpoints.registerUser),
        headers: headers, body: body);
    if (response.statusCode == 200) {
      isRegistered = true;
    }
    return isRegistered;
  }

  Future<bool> login(String email, String password) async {
    bool isLoggedIn = false;
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({'email': email, 'password': password});
    final response = await http.post(Uri.parse(APIEndpoints.loginUser),
        headers: headers, body: body);
    if (response.statusCode == 200) {
      isLoggedIn = true;
    }
    return isLoggedIn;
  }
}
