import 'package:flutter/material.dart';
import 'package:news_app/models/news_article.dart';
import 'package:news_app/utils/time_utils.dart';
import 'package:news_app/views/widgets/appbar.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailScreen extends StatelessWidget {
  final NewsArticle article;
  final String index;

  const NewsDetailScreen(
      {super.key, required this.article, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
          context: context,
          actions: [],
          automaticallyImplyLeading: true,
          title: 'MyNews'),
      backgroundColor: const Color(0XFFF5F9FD),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.urlToImage.isNotEmpty)
              Hero(
                tag: index,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    article.urlToImage,
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.broken_image, size: 200);
                    },
                  ),
                ),
              ),
            const SizedBox(height: 16),
            Text(
              article.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0XFF000000),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Source: ${article.source}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              formatTimeAgo(article.publishedAt),
              style: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '${article.description}...',
              style: const TextStyle(
                fontSize: 16,
                color: Color(0XFF000000),
              ),
            ),
            const SizedBox(height: 16),
            if (article.url.isNotEmpty)
              GestureDetector(
                onTap: () {
                  _launchURL(article.url);
                },
                child: const Text(
                  "Read full article",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
