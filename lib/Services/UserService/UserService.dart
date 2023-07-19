import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../Models/UserModel.dart';
import '../../Models/UserPreferences.dart';
import '../../Utils/strings.dart';

class UserService {
  Future<bool> updateUserInformation(
      String email, String username, File imageFile, String imageName) async {
    bool isSuccess = false;
    final request = http.MultipartRequest(
        'POST',
        Uri.parse(
            "${APIEndpoints.updateUserInfo}?username=$username&email=$email"));

    // Add the email and username query parameters
    request.files.add(http.MultipartFile.fromBytes(
        'image', await imageFile.readAsBytes(),
        filename: imageName));

    final headers = {"Content-type": "multipart/form-data"};
    request.headers.addAll(headers);

    // Send the request and wait for the response
    final response = await request.send();

    if (response.statusCode == 200) isSuccess = true;
    return isSuccess;
  }

  Future<bool> getDietSuggestions(
    String email,
    String diet,
    List<String> intolerances,
    List<String> cuisineTypes,
  ) async {
    bool isSuccess = false;
    final url = Uri.parse("${APIEndpoints.ModifyPreferences}?email=$email");
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'diet': diet,
      'intolerances': intolerances,
      'cuisineTypes': cuisineTypes,
    });

    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      isSuccess = true;
    }
    return isSuccess;
  }

  Future<UserPreferences> getUserPreferences(String email) async {
    final response = await http.get(
        Uri.parse('${APIEndpoints.GetUserPreferences}?email=$email'),
        headers: {'accept': 'text/plain'});

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      return UserPreferences.fromJson(json);
    } else {
      throw Exception('Failed to load user preferences');
    }
  }

  Future<UserModel> getUserInfo(String email) async {
    final response = await http.get(
        Uri.parse('${APIEndpoints.getUserByEmail}?email=$email'),
        headers: {
          'accept': 'application/json',
        });

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final user = UserModel.fromJson(json);
      return user;
    } else {
      throw Exception('Failed to load user');
    }
  }
}
