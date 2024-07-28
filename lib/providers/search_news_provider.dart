import 'dart:developer';
import 'package:flutter/material.dart';
import '../models/news_article.dart';
import '../services/news_service.dart';

class SearchNewsProvider with ChangeNotifier {
  final NewsService newsService = NewsService();
  List<NewsArticle> searchResults = [];
  bool isLoading = false;

  Future<void> searchNews(String query) async {
    isLoading = true;
    notifyListeners();

    try {
      searchResults = await newsService.searchNews(query);
    } catch (e) {
      log('Error searching news: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
