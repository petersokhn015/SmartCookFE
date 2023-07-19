import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../Models/NutritionFacts.dart';

class NutritionFactService {
  Future<NutritionFacts> fetchNutritionFacts(String name) async {
    final url =
        Uri.http('192.168.1.156:5000', '/api/NutritionFacts', {'name': name});
    final headers = {'Accept': '*/*'};

    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return NutritionFacts.fromJson(json);
    } else {
      throw Exception('Failed to fetch nutrition facts');
    }
  }
}
