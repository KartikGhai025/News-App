import 'dart:developer';

import 'package:flutter/material.dart';
import '../models/news_article.dart';
import '../services/news_service.dart';

class SourceNewsProvider with ChangeNotifier {
  final NewsService newsService = NewsService();
  List<NewsArticle> sourceResults = [];
  bool isLoading = false;

  Future<void> sourceNews(String source) async {
    isLoading = true;
    notifyListeners();

    try {
      sourceResults = await newsService.fetchNewsBySource(source);
    } catch (e) {

      log('Error searching news: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}