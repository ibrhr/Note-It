import 'package:notes/app/constants/exports.dart';
import 'package:notes/app/data/models/prefs/prefs_repo_imp.dart';

class SettingsController extends GetxController {
  String? get language => PrefsRepoImp.language;
  String? get theme => PrefsRepoImp.theme;

  Rx<ThemeMode> get themeMode =>
      PrefsRepoImp.theme == 'light' ? ThemeMode.light.obs : ThemeMode.dark.obs;

  bool get isDarkMode => themeMode.value == ThemeMode.dark;

  Future<void> changeLanguage(String language) async {
    Get.updateLocale(Locale(language));
    await PrefsRepoImp().changeLanguage(language);
  }

  Future<void> changeTheme(String theme) async {
    if (theme == 'light') {
      Get.changeThemeMode(ThemeMode.light);
    } else {
      Get.changeThemeMode(ThemeMode.dark);
    }
    Get.forceAppUpdate();
    print('Theme changed');
    await PrefsRepoImp().changeTheme(theme);
  }

  void init() {
    if (language == null) {
      final lang = Get.deviceLocale!.languageCode.substring(0, 2);
      if (lang == 'en' || lang == 'ar') {
        changeLanguage(lang);
      } else {
        changeLanguage('en');
      }
    }
    if (theme == null) {
      if (Get.window.platformBrightness == Brightness.light) {
        changeTheme('light');
      } else {
        changeTheme('dark');
      }
    }
  }
}
