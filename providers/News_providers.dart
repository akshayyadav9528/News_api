import 'package:flutter/material.dart';
import 'package:news/models/category_model.dart';
import 'package:news/models/news_model.dart';
import 'package:news/services/Newsservices.dart';

class NewsProviders with ChangeNotifier {
  List<Category> _category = [];
  List<News> _newsList = [];
  String? _SelectedCategory;
  bool _isLoading = false;

  List<Category> get category => _category;
  List<News> get newsList => _newsList;
  String? get selectedCategory => _SelectedCategory;
  bool get isLoading => _isLoading;

  Future<void> fetchCategories() async {
    try {
      _category = await Newsservices.fetchCategories();
    } catch (e) {
      print('error $e');
    }
  }

  Future<void> fetchNews(String? category) async {
    _isLoading = true;
    _SelectedCategory = category;
    notifyListeners();

    try {
      _newsList = await Newsservices.fetchNews(category: category);
    } catch (e) {
      print('error $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
