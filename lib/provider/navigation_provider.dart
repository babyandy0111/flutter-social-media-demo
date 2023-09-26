import 'package:flutter_riverpod/flutter_riverpod.dart';

final navigationProvider = StateNotifierProvider<NavigationNotifier, PageModel>(
    (ref) => NavigationNotifier());

enum NavigationBarEvent { HOME, BOARD, SHOPPING, VIDEO, NOTIFICATIONS, SETTINGS  }

class PageModel {
  const PageModel(this.page, this.index);
  final NavigationBarEvent page;
  final index;
}

class NavigationNotifier extends StateNotifier<PageModel> {
  NavigationNotifier() : super(defaultPage);

  static const defaultPage = PageModel(NavigationBarEvent.HOME, 0);

  void selectPage(int i) {
    switch (i) {
      case 0:
        state = PageModel(NavigationBarEvent.HOME, i);
        break;
      case 1:
        state = PageModel(NavigationBarEvent.BOARD, i);
        break;
      case 2:
        state = PageModel(NavigationBarEvent.SHOPPING, i);
        break;
      case 3:
        state = PageModel(NavigationBarEvent.VIDEO, i);
        break;
      case 4:
        state = PageModel(NavigationBarEvent.NOTIFICATIONS, i);
        break;
      case 5:
        state = PageModel(NavigationBarEvent.SETTINGS, i);
        break;
    }
  }
}
