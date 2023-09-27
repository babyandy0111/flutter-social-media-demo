import 'package:dcard/page/home/home_page.dart';
import 'package:dcard/page/welcome/welcome_page.dart';
import 'package:dcard/utils/provider_logger.dart';
import 'package:dcard/utils/shared_preferences/sp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/.env");
  await SpUtil.preInit();

  runApp(ProviderScope(
    observers: [ProviderLogger()],
    child: const App(),
  ));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  static const isLogin = null;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              appBarTheme: const AppBarTheme(color: Color(0xFF084A76)),
              colorScheme: ColorScheme.fromSwatch(
                accentColor: const Color(0xFF084A76),
              ),
            ),
            home: (isLogin == null) ? const HomePage() : const WelcomePage(),
          );
        });
  }
}