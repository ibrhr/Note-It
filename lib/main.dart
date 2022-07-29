import 'package:hive_flutter/adapters.dart';
import 'app/constants/exports.dart';
import 'app/data/models/notes/note_model/note.dart';
import 'app/global_presentation/global_features/theme_manager.dart';
import 'app/routes/app_pages.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox('notes');
  await Hive.openBox('prefs');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (BuildContext context, Widget? child) {
      return GetMaterialApp(
        title: 'Notes',
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        theme: getDarkTheme(),
        locale: const Locale('en'),
        debugShowCheckedModeBanner: false,
      );
    });
  }
}
