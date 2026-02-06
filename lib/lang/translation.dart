import 'package:get/get.dart';

class Translation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ar': {
          'home_title': 'الرئيسية',
          'welcome': 'أهلاً وسهلاً',
          'start_order': 'ابدأ الطلب',
          'login': 'تسجيل الدخول',
          'register': 'تسجيل',
          'logout': 'تسجيل الخروج',
          'profile': 'الملف الشخصي',
          'settings': 'الإعدادات',
          'orders': 'الطلبات',
          'change_language': 'تغيير اللغة',
        },
        'en': {
          'home_title': 'الرئيسية',
          'welcome': 'Welcome',
          'start_order': 'Start Order',
          'login': 'تسجيل الدخول',
          'register': 'إنشاء حساب',
          'logout': 'تسجيل الخروج',
          'profile': 'الملف الشخصي',
          'settings': 'الإعدادات',
          'orders': 'الطلبات',
          'change_language': 'Change Language',
        },
      };
}
