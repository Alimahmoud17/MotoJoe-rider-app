import 'package:flutter/material.dart';
import 'package:get/get.dart';

class الرئيسيةScreen extends StatelessWidget {
  const الرئيسيةScreen({super.key});

  void changeLang() {
    if (Get.locale == const Locale('ar')) {
      Get.updateLocale(const Locale('en'));
    } else {
      Get.updateLocale(const Locale('ar'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home'.tr),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: changeLang,
          ),
        ],
      ),
      body: Center(
        child: Text(
          'welcome'.tr,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
