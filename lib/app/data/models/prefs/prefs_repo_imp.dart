import 'package:notes/app/data/models/prefs/prefs_repo.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PrefsRepoImp extends PrefsRepo {
  static int get crossAxis {
    if (Hive.box('prefs').containsKey('crossAxis')) {
      return Hive.box('prefs').get('crossAxis');
    } else {
      return 2;
    }
  }

  @override
  Future<void> changeCrossAxis() async {
    if (Hive.box('prefs').containsKey('crossAxis')) {
      if (Hive.box('prefs').get('crossAxis') == 1) {
        Hive.box('prefs').put('crossAxis', 2);
      } else {
        Hive.box('prefs').put('crossAxis', 1);
      }
    } else {
      Hive.box('prefs').put('crossAxis', 1);
    }
  }
}
