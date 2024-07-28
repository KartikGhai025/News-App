import 'package:flutter/material.dart';
import '../../models/news_article.dart';
import '../../utils/time_utils.dart';
import '../news_detail_screen.dart';

class NewsTileWidget extends StatelessWidget {
  final NewsArticle article;
  final String index;
  const NewsTileWidget({super.key, required this.article, required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: const Color(0XFF0C54BE).withOpacity(0.5),
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                NewsDetailScreen(article: article, index: index),
          ),
        );
      },
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xffffffff),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.source,
                    style: const TextStyle(
                      color: Color(0XFF000000),
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    article.title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xff000000),
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    formatTimeAgo(article.publishedAt),
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 15),
            Hero(
              tag: index,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: 118,
                  height: 118,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(article.urlToImage),
                    ),
                  ),
                  child: article.urlToImage.isNotEmpty
                      ? Image.network(article.urlToImage,
                          errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.broken_image);
                        })
                      : const Icon(Icons.broken_image),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
