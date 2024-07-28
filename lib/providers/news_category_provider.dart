import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/news_article.dart';
import '../services/news_service.dart';
import '../services/remote_config_service.dart';

class CategoryNewsProvider with ChangeNotifier {
  final NewsService newsService = NewsService();
  List<NewsArticle> articles = [];
  Map<String, List<NewsArticle>> articlesMap = {};  // I used this map , so that fetched category list will not be fetched again ,hence reducing the number of api calls
  bool isLoading = false;

  Future<void> categoryNews(String category, BuildContext context) async {
    isLoading = true;
    notifyListeners();
    final remoteConfigService =
        Provider.of<RemoteConfigService>(context, listen: false);
    String country = remoteConfigService.getCountryCode();

    if (articlesMap.containsKey(category)) {
      articles = articlesMap[category]!;
    } else {
      try {
        articles = await newsService.fetchNewsByCategory(category, country);
        articlesMap[category] = articles;
      } catch (e) {
        log('Error fetching news: $e');
      }
    }

    isLoading = false;
    notifyListeners();
  }
}
