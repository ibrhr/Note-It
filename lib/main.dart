import 'package:hive_flutter/adapters.dart';
import 'app/global_presentation/global_features/theme_manager.dart';
import 'app/modules/home/bindings/home_binding.dart';
import 'app/modules/settings/controllers/settings_controller.dart';
import 'app/constants/exports.dart';
import 'app/data/models/notes/note_model/note.dart';
import 'app/routes/app_pages.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox('notes');
  await Hive.openBox('prefs');
  final settings = Get.put<SettingsController>(SettingsController());
  settings.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: ScreenUtil.defaultSize,
        builder: (BuildContext context, Widget? child) {
          return GetMaterialApp(
            title: 'Note It',
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
            theme: MyThemes.light,
            darkTheme: MyThemes.dark,
            //themeMode: ThemeMode.dark,
            themeMode: Get.find<SettingsController>().themeMode.value,
            initialBinding: HomeBinding(),
            locale: Locale(Get.find<SettingsController>().language!),
            debugShowCheckedModeBanner: false,
            translationsKeys: AppTranslation.translations,
          );
        });
  }
}
