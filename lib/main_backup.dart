import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'lang/translation.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MotoGo',
      translations: Translation(),     // دعم الترجمة
      locale: const Locale('ar'),      // اللغة الافتراضية: عربي
      fallbackLocale: const Locale('en'),
      home: const الرئيسيةScreen(),
    );
  }
}
