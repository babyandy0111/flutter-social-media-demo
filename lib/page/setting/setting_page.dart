// import 'package:dcard/provider/search_text_provider.dart';
import 'package:dcard/page/home/all_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../utils/shared_preferences/sp.dart';
import '../all_login_page.dart';
import '../login/login_page.dart';

// final searchTextProvider =
//     ChangeNotifierProvider((ref) => SearchTextNotifier());

class SettingPage extends ConsumerWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     ref.read(searchTextProvider).setValue("9999");
        //   },
        //   child: const Icon(Icons.add),
        // ),
        body: Row(children: [
      SettingsList(sections: [
        SettingsSection(
          title: const Text('Section 1'),
          tiles: [
            SettingsTile(
              title: const Text('Language'),
              leading: const Icon(Icons.language),
              onPressed: (BuildContext context) {},
            ),
            SettingsTile(
              onPressed: (BuildContext context) {
                SpUtil.getInstance().setData('isLogin', false);
                Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const AllLoginPage();
                    },
                  ),
                  (_) => false,
                );
              },
              title: const Text('Logout'),
              leading: const Icon(Icons.logout),
            ),
          ],
        ),
      ]),
      // Expanded(
      //   child: Container(
      //       alignment: Alignment.bottomCenter,
      //       child:
      //           Text(ref.watch(searchTextProvider).searchText.toString())),
      // ),
    ]));
  }
}
