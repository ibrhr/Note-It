import '../../modules/settings/controllers/settings_controller.dart';
import '../../constants/exports.dart';

class MyThemes {
  static final light = ThemeData.light().copyWith(
    // main colors of the app
    // primaryColor: ColorManager.primary,
    //  primaryColorLight: ColorManager.primaryOpacity70,
    disabledColor: ColorManager.grey,
    //   brightness: Brightness.light,
    backgroundColor: ColorManager.scaffoldLightColor,
    scaffoldBackgroundColor: ColorManager.scaffoldLightColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    hintColor: ColorManager.grey6,

    // Text Theme
    textTheme: TextTheme(bodyLarge: TextStyle(color: ColorManager.black)),

    // Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (states) => ColorManager.scaffoldLightColor))),

    //Icon Theme
    iconTheme: IconThemeData(color: ColorManager.black, size: 22.h),

    // App bar theme
    appBarTheme: AppBarTheme(
      color: ColorManager.scaffoldLightColor,
      iconTheme: IconThemeData(color: ColorManager.white),
      elevation: 0,
      centerTitle: true,
    ),
  );
  static final dark = ThemeData.dark().copyWith(
    // main colors of the app
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.primaryOpacity70,
    disabledColor: ColorManager.grey,
    //   brightness: Brightness.dark,
    backgroundColor: ColorManager.scaffoldDarkColor,
    scaffoldBackgroundColor: ColorManager.scaffoldDarkColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    hintColor: ColorManager.grey6,

    // Text Theme
    textTheme: TextTheme(bodyLarge: TextStyle(color: ColorManager.grey7)),

    // Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (states) => ColorManager.scaffoldDarkColor))),

    //Icon Theme
    iconTheme: IconThemeData(color: ColorManager.white, size: 22.h),

    // App bar theme
    appBarTheme: AppBarTheme(
      color: ColorManager.scaffoldDarkColor,
      iconTheme: IconThemeData(color: ColorManager.white),
      elevation: 0,
      centerTitle: true,
    ),
  );

  static bool get isDarkMode => Get.find<SettingsController>().isDarkMode;
}
