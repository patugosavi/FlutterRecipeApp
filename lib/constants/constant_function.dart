import 'dart:convert';

import 'package:http/http.dart' as http;

class ConstantFunction {
  static Future<List<Map<String, dynamic>>> getResponse(
      String findRecipe) async {
    try {
      String id = "09fd8bd5";
      String key = "d80ed133a6efc85e76ae8cf898896bd5";
      String api =
          "https://api.edamam.com/search?q=$findRecipe&app_id=$id&app_key=$key&from=0&to=80&calories=591-722&health=alcohol-free";

      final response = await http.get(Uri.parse(api));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        List<Map<String, dynamic>> recipe = [];
        if (data['hits'] != null) {
          for (var hit in data['hits']) {
            recipe.add(hit['recipe']);
          }
        }
        return recipe;
      } else {
        // print("Failed to load data: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      // print("Error occurred: $e");
      return [];
    }
  }
}
