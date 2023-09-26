import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dcard/api/notification_api.dart';
import 'package:dcard/state/list_view_notifier.dart';
import 'package:dcard/state/list_view_state.dart';
import '../../model/notification_model/notification_model.dart';

// final sessionTimeProvider StreamProvider<int>((_=getSessionTime(),

final notificationListProvider = StateNotifierProvider<
    ListViewStateNotifier<NotificationModel>,
    ListViewState<List<NotificationModel>>>((ref) {
  final api = ref.watch(apiService);
  return ListViewStateNotifier<NotificationModel>(
      pageIndex: 1,
      pageSize: 10,
      fetchItems: (int pageIndex, int pageSize) {
        return api.fetchProducts(pageIndex: pageIndex, pageSize: pageSize);
      });
});

class NotificationStateNotifier
    extends StateNotifier<ListViewState<List<NotificationModel>>> {
  NotificationStateNotifier({required this.api})
      : super(const ListViewState.loading()) {
    init();
  }

  final EasyRefreshController _refreshController = EasyRefreshController();

  EasyRefreshController get refreshController => _refreshController;

  final NotificationAPI api;

  int _page = 0;
  List<NotificationModel> _notifications = [];

  void init() {
    firstLoadPage();
  }

  Future<void> firstLoadPage() async {
    _page = 1;
    try {
      final List<NotificationModel> list =
          await api.fetchProducts(pageIndex: _page, pageSize: 10);
      if (list.isEmpty) {
        state = const ListViewState.empty();
      } else {
        _notifications = list;
        state = ListViewState.ready(list);
      }
      _refreshController.finishRefresh(success: true);
    } catch (e) {
      state = ListViewState.error(error: e.toString());
    }
  }

  Future<void> refreshData({ToastFunction? fnToast}) async {
    _page = 1;
    try {
      // state = const ListViewState.loading();
      final List<NotificationModel> list =
          await api.fetchProducts(pageIndex: _page, pageSize: 10);
      if (list.isEmpty) {
        state = const ListViewState.empty();
      } else {
        _notifications = list;
        state = ListViewState.ready(list);
      }
      _refreshController.finishRefresh(success: true);
    } catch (e) {
      _refreshController.finishRefresh(success: false);
      if (fnToast != null) {
        fnToast(e.toString());
      }
    }
  }

  Future<void> loadMore({ToastFunction? fnToast}) async {
    _page += 1;
    try {
      final List<NotificationModel> list =
          await api.fetchProducts(pageIndex: _page, pageSize: 10);
      if (list.isNotEmpty) {
        _notifications.addAll(list);
        state = ListViewState.ready(_notifications);
      }
      _refreshController.finishLoad(success: true, noMore: true);
    } catch (e) {
      _refreshController.finishLoad(success: false, noMore: false);
      if (fnToast != null) {
        fnToast(e.toString());
      }
    }
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
}

final NotificationModelProvider = StateNotifierProvider<NotificationStateNotifier,
        ListViewState<List<NotificationModel>>>(
    (ref) => NotificationStateNotifier(api: ref.watch(apiService)));
