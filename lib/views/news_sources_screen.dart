import 'package:flutter/material.dart';
import 'package:news_app/views/source_news_screen.dart';
import 'package:news_app/views/widgets/appbar.dart';

class NewsSourceScreen extends StatelessWidget {
  final List<String> sources = [
    'techcrunch',
    'bbc-news',
    'cnn',
    'the-verge',
  ];

  NewsSourceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFF5F9FD),
      appBar: buildAppBar(
          context: context,
          actions: [],
          automaticallyImplyLeading: true,
          title: 'News Sources'),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 3, // Adjust as needed
        ),
        itemCount: sources.length,
        itemBuilder: (context, index) {
          final source = sources[index];
          final isBlue = (index % 3 == 0);
          final backgroundColor =
              isBlue ? const Color(0XFF0C54BE) : Colors.white;
          final textColor = isBlue ? Colors.white : Colors.black;

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SourceNewsScreen(source: source),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey, width: 1),
              ),
              alignment: Alignment.center,
              child: Text(
                source.toUpperCase(),
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
      ),
    );
  }
}
