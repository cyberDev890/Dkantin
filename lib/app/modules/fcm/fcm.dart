import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FCMService extends GetxService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');

    // Get the FCM token
    String? fcmToken = await _firebaseMessaging.getToken();
    print('FCM Token: $fcmToken');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('tokenfcm', fcmToken!);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("FCM Message data: ${message.data}");
      print("FCM Message notification: ${message.notification}");
      // Handle your message here using GetX controllers or other logic
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("FCM Message opened app: ${message.data}");
      // Handle your message here using GetX controllers or other logic
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print("Handling a background message: ${message.data}");
    // Handle your message here using GetX controllers or other logic
  }
}
