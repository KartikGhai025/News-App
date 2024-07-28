import 'package:flutter/material.dart';
import 'package:news_app/views/widgets/news_tile.dart';
import 'package:news_app/views/widgets/shimmer_effect.dart';
import 'package:provider/provider.dart';
import '../models/news_article.dart';
import '../providers/news_category_provider.dart';

class CategoryNewsScreen extends StatefulWidget {
  final String category;

  const CategoryNewsScreen({super.key, required this.category});

  @override
  State<CategoryNewsScreen> createState() => _CategoryNewsScreenState();
}

class _CategoryNewsScreenState extends State<CategoryNewsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryNewsProvider>().categoryNews(widget.category, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFF5F9FD),
      body: Consumer<CategoryNewsProvider>(
        builder: (context, newsProvider, child) {
          if (newsProvider.isLoading) {
            return const ShimmerLoading();
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
