import 'package:cached_network_image/cached_network_image.dart';
import 'package:dcard/page/home/notification_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../model/notification_model/notification_model.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(notificationListProvider);
          return state.when(
            empty: () => const Text(
              'empty',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            ready: (data) => _buildContent(context, ref, data),
            error: (String error) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(error),
                    ),
                    TextButton(
                      child: const Text("重試一下"),
                      onPressed: () {
                        ref.refresh(notificationListProvider);
                      },
                    ),
                  ],
                ),
              );
            },
            loading: () => const Center(child: Text("loading..")),
          );
        },
      ),
    );
  }

  Widget _buildContent(
      BuildContext ctx, WidgetRef ref, List<NotificationModel> data) {
    return Center(
      child: EasyRefresh(
        controller:
            ref.watch(notificationListProvider.notifier).refreshController,
        enableControlFinishLoad: true,
        enableControlFinishRefresh: true,
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: ((context, index) {
            return GestureDetector(
                onTap: () {
                  print(data[index].title ?? "");
                },
                child: Container(
                    // color: Colors.black,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      // borderRadius: BorderRadius.all(
                      //   Radius.circular(12),
                      // ),
                    ),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 0,
                      vertical: 1,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 15,
                    ),
                    child: Column(children: [
                      Row(children: [
                        CachedNetworkImage(
                          width: 56,
                          height: 56,
                          imageUrl: data[index].thumbnailUrl ?? "",
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(data[index].title ?? ""),
                          ),
                        ),
                      ]),
                      const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Divider(height: 1, color: Colors.black),
                      ),
                    ])));
          }),
        ),
        onRefresh: () async {
          ref.watch(notificationListProvider.notifier).refreshData(
              fnToast: ((error, {e}) {
            ScaffoldMessenger.of(ctx).showSnackBar(
              SnackBar(
                  content: Text(
                error,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              )),
            );
          }));
        },
        onLoad: () async {
          ref.watch(notificationListProvider.notifier).loadMore(
              fnToast: ((error, {e}) {
            ScaffoldMessenger.of(ctx).showSnackBar(
              SnackBar(
                  content: Text(
                error,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              )),
            );
          }));
        },
      ),
    );
  }
}
