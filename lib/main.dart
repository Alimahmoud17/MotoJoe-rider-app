import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'global/translations.dart';
import 'screens/auth/register_screen.dart'; // استدعاء شاشة التسجيل

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Riders App',
      translations: AppTranslations(),
      locale: const Locale('ar'),
      fallbackLocale: const Locale('en'),
      home: const إنشاء حسابScreen(), // تشغيل شاشة التسجيل مباشرة
    );
  }
}
