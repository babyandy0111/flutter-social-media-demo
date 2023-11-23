import 'package:dcard/page/all_login_page.dart';
import 'package:dcard/page/home/home_page.dart';
import 'package:dcard/utils/provider_logger.dart';
import 'package:dcard/utils/shared_preferences/sp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'messaging_service.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await dotenv.load(fileName: "assets/.env");
  await SpUtil.preInit();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print("FCMToken $fcmToken");
  runApp(ProviderScope(
    observers: [ProviderLogger()],
    child: DevicePreview(
      enabled: false,
      tools: const [...DevicePreview.defaultTools],
      builder: (BuildContext context) => MyApp(),
    ),
  ));
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final messagingService = MessagingService();

  @override
  void initState() {
    super.initState();
    messagingService.init();
  }

  @override
  Widget build(BuildContext context) {
    bool isLogin = SpUtil.getInstance().get('isLogin') ?? false;
    FlutterNativeSplash.remove();
    return ScreenUtilInit(
        designSize: const Size(360, 640),
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
            home: (isLogin) ? const HomePage() : const AllLoginPage(),
          );
        });
  }
}
