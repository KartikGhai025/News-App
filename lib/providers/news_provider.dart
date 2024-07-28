import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/news_article.dart';
import '../services/news_service.dart';
import '../services/remote_config_service.dart';

class TopNewsProvider with ChangeNotifier {
  final NewsService newsService = NewsService();
  List<NewsArticle> articles = [];

  bool isLoading = false;

  Future<void> fetchNews(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    final remoteConfigService =
        Provider.of<RemoteConfigService>(context, listen: false);
    String country = remoteConfigService.getCountryCode();

    try {
      articles = await newsService.fetchTopHeadlines(country);
    } catch (e) {
      log('Error fetching news: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

/*
  Future<void> searchNews(String query) async {
    isLoading = true;
    notifyListeners();

    try {
      articles = await newsService.searchNews(query);
    } catch (e) {
      log('Error searching news: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
*/

 /* Future<void> fetchNewsBySource(String source) async {
    isLoading = true;
    notifyListeners();

    try {
      articles = await newsService.fetchNewsBySource(source);
    } catch (e) {
      log('Error fetching news by source: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }*/
}
