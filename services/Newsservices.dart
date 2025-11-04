import 'dart:convert';
import 'package:news/models/category_model.dart';
import 'package:http/http.dart' as http;
import 'package:news/models/news_model.dart';

class Newsservices {
  static const String baseUrl =
      "http://localhost:4502/api"; // Match backend port

  static Future<List<Category>> fetchCategories() async {
    print("welcome");
    try {
      final response = await http.get(Uri.parse('$baseUrl/categories'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true && data['data'] != null) {
          return List<Category>.from(
            data['data'].map((json) => Category.fromJson(json)),
          );
        }
        throw Exception('Invalid response format');
      } else {
        throw Exception('Failed to fetch categories: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching categories: $e');
      rethrow;
    }
  }

  static Future<List<News>> fetchNews({String? category}) async {
    try {
      final queryParams = <String, String>{};
      if (category != null && category.toLowerCase() != 'all') {
        // Convert category to match backend enum case
        final backendCategory =
            category[0].toUpperCase() + category.substring(1).toLowerCase();
        queryParams['category'] = backendCategory;
      }

      final uri = Uri.parse(
        '$baseUrl/news',
      ).replace(queryParameters: queryParams);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<News>.from(data['data'].map((json) => News.fromJson(json)));
      } else {
        throw Exception('failed to fetch Categories');
      }
    } catch (e) {
      print('$e');
      return [];
    }
  }
}
