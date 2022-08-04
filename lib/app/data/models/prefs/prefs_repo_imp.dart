import 'package:notes/app/data/models/prefs/prefs_repo.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PrefsRepoImp extends PrefsRepo {
  static final box = Hive.box('prefs');

  static int get crossAxis {
    if (box.containsKey('crossAxis')) {
      return box.get('crossAxis');
    } else {
      return 2;
    }
  }

  static String? get language {
    if (box.containsKey('language')) {
      return box.get('language');
    } else {
      return null;
    }
  }

  static String? get theme {
    if (box.containsKey('theme')) {
      return box.get('theme');
    } else {
      return null;
    }
  }

  @override
  Future<void> changeCrossAxis() async {
    if (box.containsKey('crossAxis')) {
      if (box.get('crossAxis') == 1) {
        box.put('crossAxis', 2);
      } else {
        box.put('crossAxis', 1);
      }
    } else {
      box.put('crossAxis', 1);
    }
  }

  @override
  Future<void> changeLanguage(String language) async {
    await box.put('language', language);
  }

  @override
  Future<void> changeTheme(String theme) async {
    box.put('theme', theme);
  }
}
