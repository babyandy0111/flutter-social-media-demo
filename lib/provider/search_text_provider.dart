import 'package:flutter/cupertino.dart';

// final StateProvider<String> searchTextProvider = StateProvider((ref) => "ooooooooo");
/// https://juejin.cn/post/7103525657035931656
class SearchTextNotifier extends ChangeNotifier {
  String searchText = 'oooo';

  void setValue(value) {
    searchText = value;
    notifyListeners();
  }
}