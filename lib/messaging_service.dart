import 'package:firebase_messaging/firebase_messaging.dart';

class MessagingService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<void> init() async {
    _fcm.requestPermission();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage: ${message.data}");
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onMessageOpenedApp: ${message.data}");
    });
  }
}
