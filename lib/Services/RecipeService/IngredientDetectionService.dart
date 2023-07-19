import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class IngredientDetectionService {
  Future<Map<String, dynamic>> getIngredients(File imageFile) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://192.168.1.103:8001/getIngredients'),
    );

    request.files.add(
      await http.MultipartFile.fromPath('image', imageFile.path),
    );

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode != 200) {
      throw Exception('Failed to get ingredients');
    }

    var responseData = json.decode(response.body);

    return responseData;
  }
}