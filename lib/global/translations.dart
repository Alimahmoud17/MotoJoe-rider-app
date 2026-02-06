import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ar': {
          'home': 'الرئيسية',
          'welcome': 'أهلاً بك',
          'login': 'تسجيل الدخول',
          'register': 'تسجيل حساب',
          'change_language': 'تغيير اللغة',
        },
        'en': {
          'home': 'الرئيسية',
          'welcome': 'Welcome',
          'login': 'تسجيل الدخول',
          'register': 'إنشاء حساب',
          'change_language': 'Change Language',
        }
      };
}
