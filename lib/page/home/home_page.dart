import 'package:dcard/page/home/components/home_page_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dcard/provider/navigation_provider.dart';

/// [傳值] https://blog.csdn.net/weixin_42322441/article/details/109237716
class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PageModel navigation = ref.watch(navigationProvider);
    return Scaffold(
      body: HomePageDetail(currentPageIndex: navigation.index),
      bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: const Color(0xFF084A76),
          fixedColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          currentIndex: navigation.index,
          onTap: (index) {
            ref.read(navigationProvider.notifier).selectPage(index);
          },
          items: const [
            BottomNavigationBarItem(
              label: "首頁",
              icon: Icon(
                Icons.home,
                // key: Keys.NAV_HOME,
              ),
            ),
            BottomNavigationBarItem(
              label: "看板",
              icon: Icon(
                Icons.star_border,
              ),
            ),
            BottomNavigationBarItem(
              label: "商城",
              icon: Icon(
                Icons.shopping_basket,
              ),
            ),
            BottomNavigationBarItem(
              label: "影音",
              icon: Icon(
                Icons.slow_motion_video_sharp,
              ),
            ),
            BottomNavigationBarItem(
              label: "通知",
              icon: Icon(
                Icons.notifications,
              ),
            ),
            BottomNavigationBarItem(
              label: "設定",
              icon: Icon(
                Icons.settings,
              ),
            ),
          ]),
    );
  }
}