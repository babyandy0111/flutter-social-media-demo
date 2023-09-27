import 'package:dcard/page/home/components/tabbar_view.dart';
import 'package:dcard/page/setting/setting_page.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:dcard/page/shopping/shopping_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../provider/search_text_provider.dart';
import '../../board/board_page.dart';
import '../../notification/notification_page.dart';
import '../../video/video_page.dart';
import '../post_article_page.dart';

final searchTextProvider =
    ChangeNotifierProvider((ref) => SearchTextNotifier());

class HomePageDetail extends StatefulWidget {
  final int currentPageIndex;

  const HomePageDetail({Key? key, required this.currentPageIndex})
      : super(key: key);

  @override
  State<HomePageDetail> createState() => _HomePageDetailState();
}

class _HomePageDetailState extends State<HomePageDetail>
    with SingleTickerProviderStateMixin {
  String searchValue = '';

  final List<String> _suggestions = [
    'Afeganistan',
    'Albania',
    'Algeria',
    'Australia',
    'Brazil',
    'German',
    'Madagascar',
    'Mozambique',
    'Portugal',
    'Zambia'
  ];

  Future<List<String>> _fetchSuggestions(String searchValue) async {
    await Future.delayed(const Duration(milliseconds: 750));
    return _suggestions.where((element) {
      return element.toLowerCase().contains(searchValue.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    int index = widget.currentPageIndex;
    EasySearchBar searchBar = EasySearchBar(
        backgroundColor: const Color(0xFF084A76),
        foregroundColor: Colors.white,
        searchBackgroundColor: Colors.white,
        title: const Text(''),
        onSearch: (value) => setState(() => searchValue = value),
        asyncSuggestions: (value) async => await _fetchSuggestions(value));

    Widget page = Center(child: Text('Value: $searchValue'));

    switch (index) {
      case 0:
        page = HomeTabBarView(
          searchText: searchValue,
        );
        break;
      case 1:
        page = const BoardPage();
        break;
      case 2:
        page = const ShoppingPage();
        break;
      case 3:
        page = VideoPage();
        break;
      case 4:
        page = const NotificationPage();
        break;
      case 5:
        page = const SettingPage();
        break;
    }

    return MaterialApp(
      title: '',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: Scaffold(
        appBar: searchBar,
        body: page,
        floatingActionButton: index != 3
            ? FloatingActionButton(
                backgroundColor: const Color(0xFF539DCE),
                foregroundColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PostArticlePage()));
                },
                child: const Icon(Icons.add),
              )
            : Container(),
      ),
    );
  }
}
