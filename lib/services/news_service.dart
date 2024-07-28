import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news_article.dart';

class NewsService {
  final String apiKey =
      'e3e031adfbdd4e598aa96a19f744eba7'; //'a19a60561aa54b548989b30bc50264ed';
  final String topHeadlinesApiUrl = 'https://newsapi.org/v2/top-headlines';
  final String everythingApiUrl = 'https://newsapi.org/v2/everything';

  Future<List<NewsArticle>> fetchTopHeadlines(String country) async {
    var response = await http
        .get(Uri.parse('$topHeadlinesApiUrl?country=$country&apiKey=$apiKey'));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var articles = json['articles'] as List;
      return articles.map((article) => NewsArticle.fromJson(article)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }

  Future<List<NewsArticle>> searchNews(String query) async {
    var response = await http.get(Uri.parse(
        '$everythingApiUrl?q=$query&sortBy=publishedAt&apiKey=$apiKey'));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var articles = json['articles'] as List;
      return articles.map((article) => NewsArticle.fromJson(article)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }

  Future<List<NewsArticle>> fetchNewsBySource(String source) async {
    var response = await http
        .get(Uri.parse('$topHeadlinesApiUrl?sources=$source&apiKey=$apiKey'));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var articles = json['articles'] as List;
      return articles.map((article) => NewsArticle.fromJson(article)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }

  Future<List<NewsArticle>> fetchNewsByCategory(
      String category, String country) async {
    var response = await http.get(Uri.parse(
        '$topHeadlinesApiUrl?country=$country&category=$category&apiKey=$apiKey'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<NewsArticle> articles = (data['articles'] as List)
          .map((article) => NewsArticle.fromJson(article))
          .toList();
      return articles;
    } else {
      throw Exception('Failed to fetch news');
    }
  }
}
