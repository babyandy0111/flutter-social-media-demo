import 'package:flutter/material.dart';
import 'package:dcard/page/home/all_page.dart';
import 'package:dcard/page/notification/notification_page.dart';

import '../recommend_page.dart';
import '../topic_page.dart';
import '../track_page.dart';

class HomeTabBarView extends StatefulWidget {

  const HomeTabBarView({super.key, required this.searchText});

  final String searchText;

  @override
  State<HomeTabBarView> createState() => HomeTabBarViewState(searchText: searchText);
}

class HomeTabBarViewState extends State<HomeTabBarView>
    with SingleTickerProviderStateMixin {
  List tabs = ["推薦", "全部", "追蹤", "主題"];
  late TabController tabController;
  late String searchText;
  HomeTabBarViewState({required String searchText});

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TabBar(
          tabs: tabs.map((text) => Tab(text: text)).toList(),
          controller: tabController,
          labelColor: Colors.black,
          indicatorColor: const Color(0xFF084A76),
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: tabs.map((text) {
              return Center(
                child: CurrentPage(title: text, searchText: widget.searchText),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class CurrentPage extends StatefulWidget {
  final String title;
  final String searchText;

  const CurrentPage({Key? key, required this.title, required this.searchText})
      : super(key: key);

  @override
  State<CurrentPage> createState() => Page();
}

class Page extends State<CurrentPage> {
  @override
  Widget build(BuildContext context) {
    String title = widget.title;
    String searchText = widget.searchText;
    Widget w = Text(title, textScaleFactor: 5);

    switch (title) {
      case '推薦':
        w = const RecommendPage();
        break;
      case '全部':
        w = const AllPage();
        break;
      case '追蹤':
        w = const TrackPage();
        break;
      case '主題':
        w = const TopicPage();
        break;
    }

    return Scaffold(
      body: w,
    );
  }
}
