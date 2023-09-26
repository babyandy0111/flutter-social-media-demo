import 'package:dcard/provider/search_text_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';

final searchTextProvider =
    ChangeNotifierProvider((ref) => SearchTextNotifier());

class SettingPage extends ConsumerWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ref.read(searchTextProvider).setValue("9999");
          },
          child: const Icon(Icons.add),
        ),
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
                SettingsTile.switchTile(
                  title: const Text('Use System Theme'),
                  leading: const Icon(Icons.phone_android),
                  onToggle: (value) {},
                  initialValue: null,
                ),
              ],
            ),
          ]),
          Expanded(
            child: Container(
                alignment: Alignment.bottomCenter,
                child:
                    Text(ref.watch(searchTextProvider).searchText.toString())),
          ),
        ]));
  }
}
