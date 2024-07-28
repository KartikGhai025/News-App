import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:news_app/views/category_news_screen.dart';
import 'package:news_app/views/top_news_screen.dart';
import 'package:news_app/views/profile_screen.dart';
import 'package:news_app/views/search_news_screen.dart';
import 'package:news_app/views/widgets/appbar.dart';
import 'package:provider/provider.dart';
import '../services/authentication_service.dart';
import '../services/remote_config_service.dart';
import 'news_sources_screen.dart';

class NewsHomePage extends StatefulWidget {
  const NewsHomePage({
    super.key,
  });

  @override
  _NewsHomePageState createState() => _NewsHomePageState();
}

class _NewsHomePageState extends State<NewsHomePage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;
  final List<String> categories = [
    'Top Headlines',
    'business',
    'entertainment',
    'general',
    'health',
    'science',
    'sports',
    'technology'
  ];

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: 0);

    _pageController.addListener(() {
      int currentPage = _pageController.page?.round() ?? 0;
      if (_tabController.index != currentPage) {
        _tabController.animateTo(currentPage);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> list =
        // Text('Top Headlines'),

        categories.map((value) {
      return Text(value.isNotEmpty
          ? '${value[0].toUpperCase()}${value.substring(1)}'
          : '');
    }).toList();

    _tabController = TabController(length: list.length, vsync: this);
    return Scaffold(
      backgroundColor: const Color(0XFFF5F9FD),
      body: Column(
        children: [
          //  SizedBox(height: 16),
          TabBar(
              dividerHeight: 0,
              tabAlignment: TabAlignment.start,
              controller: _tabController,
              indicatorColor: Colors.transparent,
              unselectedLabelColor: const Color(0XFF0C54BE),
              isScrollable: true,
              indicatorWeight: 1,
              indicatorSize: TabBarIndicatorSize.tab,
              labelStyle: const TextStyle(
                color: Color(0XFF000000),
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
              ),
              physics: const BouncingScrollPhysics(),
              automaticIndicatorColorAdjustment: true,
              labelPadding: const EdgeInsets.all(10.0),
              enableFeedback: true,
              onTap: (index) {
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              tabs: list),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: PageView(
                //    physics: PageScrollPhysics(),
                onPageChanged: (index) {
                  _tabController.animateTo(index);
                },
                controller: _pageController,
                children: [
                  const TopNewsScreen(),
                  for (int i = 1; i < list.length; i++)
                    CategoryNewsScreen(category: categories[i])
                ]),
          ),
        ],
      ),
      appBar: buildAppBar(
        context: context,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SearchNewsScreen()));
            },
          ),
          const Icon(
            FontAwesome.location_arrow_solid,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Text(
            Provider.of<RemoteConfigService>(context)
                .getCountryCode()
                .toUpperCase(),
            style: const TextStyle(
              color: Color(0XFFF5F9FD),
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
            ),
          ),
          PopupMenuButton<String>(
            color: const Color(0XFFF5F9FD),
            onSelected: (String value) {
              if (value == 'Profile') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileScreen()));
              } else if (value == 'Sources') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewsSourceScreen()));
              } else if (value == 'Logout') {
                context.read<AuthenticationService>().signOut();
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'Profile',
                  child: Row(
                    children: [
                      Icon(Icons.person, color: Color(0XFF0C54BE)),
                      SizedBox(width: 8),
                      Text('Profile'),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'Sources',
                  child: Row(
                    children: [
                      Icon(Icons.category, color: Color(0XFF0C54BE)),
                      SizedBox(width: 8),
                      Text('Sources'),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'Logout',
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: Color(0XFF0C54BE),
                      ),
                      SizedBox(width: 8),
                      Text('Logout'),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
        automaticallyImplyLeading: false,
        title: 'MyNews',
      ),
    );
  }
}
