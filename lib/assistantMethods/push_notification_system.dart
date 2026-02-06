import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class PushNotificationSystem
{
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<void> initializeCloudMessaging(BuildContext context) async
  {
    // طلب إذن الإشعارات
    Notificationالإعدادات settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    print("🔔 Notification permission: ${settings.authorizationStatus}");

    // استقبال رسالة عند فتح التطبيق
    FirebaseMessaging.onMessage.listen((RemoteMessage message)
    {
      print("📩 New Notification: ${message.notification?.title}");
      print("📩 Body: ${message.notification?.body}");
    });

    // لما التطبيق مقفول وفتح من الإشعار
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message)
    {
      print("📩 Notification Clicked");
    });
  }
}
