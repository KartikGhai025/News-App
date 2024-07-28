import 'package:flutter/material.dart';
import 'package:news_app/models/news_article.dart';
import 'package:news_app/views/widgets/news_tile.dart';
import 'package:news_app/views/widgets/shimmer_effect.dart';
import 'package:provider/provider.dart';
import '../providers/news_provider.dart';

class TopNewsScreen extends StatefulWidget {
  const TopNewsScreen({super.key});

  @override
  State<TopNewsScreen> createState() => _TopNewsScreenState();
}

class _TopNewsScreenState extends State<TopNewsScreen> {
  @override
  void initState() {
    context.read<TopNewsProvider>().fetchNews(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFF5F9FD),
      body: Consumer<TopNewsProvider>(
        builder: (context, newsProvider, child) {
          if (newsProvider.isLoading) {
            return ShimmerLoading();
          }

          if (newsProvider.articles.isEmpty) {
            return const Center(child: Text('No news available'));
          }

          List<NewsArticle> list = [
            ...newsProvider.articles
                .where((element) => element.urlToImage.isNotEmpty),
            ...newsProvider.articles
                .where((element) => element.urlToImage.isEmpty),
          ];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: ListView.separated(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: list.length,
              separatorBuilder: (context, index) => const SizedBox(height: 14),
              itemBuilder: (context, index) => NewsTileWidget(
                article: list[index],
                index: index.toString(),
              ),
            ),
          );
        },
      ),
    );
  }
}
