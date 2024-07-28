import 'package:flutter/material.dart';
import 'package:news_app/views/widgets/appbar.dart';
import 'package:news_app/views/widgets/news_tile.dart';
import 'package:news_app/views/widgets/shimmer_effect.dart';
import 'package:provider/provider.dart';
import '../providers/news_source_provider.dart';

class SourceNewsScreen extends StatefulWidget {
  final String source;

  const SourceNewsScreen({super.key, required this.source});

  @override
  State<SourceNewsScreen> createState() => _SourceNewsScreenState();
}

class _SourceNewsScreenState extends State<SourceNewsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SourceNewsProvider>().sourceNews(widget.source);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
          context: context,
          actions: [],
          automaticallyImplyLeading: true,
          title: "News from ${widget.source.toUpperCase()}"),
      backgroundColor: const Color(0XFFF5F9FD),
      body: Consumer<SourceNewsProvider>(
        builder: (context, newsProvider, child) {
          if (newsProvider.isLoading) {
            return const ShimmerLoading();
          }

          if (newsProvider.sourceResults.isEmpty) {
            return const Center(child: Text('No news available'));
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 14),
                  const Text(
                    "Top Headlines",
                    style: TextStyle(
                      color: Color(0XFF000000),
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 14),
                  ListView.separated(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: newsProvider.sourceResults.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 14),
                    itemBuilder: (context, index) =>
                        NewsTileWidget(
                      article: newsProvider.sourceResults[index],
                          index: index.toString(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
