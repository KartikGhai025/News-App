import 'package:flutter/material.dart';
import 'package:news_app/views/widgets/appbar.dart';
import 'package:news_app/views/widgets/news_tile.dart';
import 'package:news_app/views/widgets/shimmer_effect.dart';
import 'package:provider/provider.dart';
import '../providers/search_news_provider.dart';

class SearchNewsScreen extends StatelessWidget {
  const SearchNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
          context: context,
          actions: [],
          automaticallyImplyLeading: true,
          title: 'search News'),
      backgroundColor: const Color(0XFFF5F9FD),
      body: const SearchNewsBody(),
    );
  }
}

class SearchNewsBody extends StatelessWidget {
  const SearchNewsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onSubmitted: (query) {
              Provider.of<SearchNewsProvider>(context, listen: false)
                  .searchNews(query);
            },
            style: const TextStyle(
              color: Color(0XFF000000),
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: 'Search for news...',
              hintStyle: const TextStyle(
                color: Color(0XFF000000),
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: const Color(0xFFFFFFFF),
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            ),
          ),
        ),


        Expanded(
          child: Consumer<SearchNewsProvider>(
            builder: (context, provider, _) {
              if (provider.isLoading) {
                return const ShimmerLoading();
              }

              if (provider.searchResults.isEmpty) {
                return const Center(child: Text('No results found'));
              }

              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: provider.searchResults.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 14),
                itemBuilder: (context, index) => NewsTileWidget(
                  article: provider.searchResults[index],
                  index: index.toString(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

