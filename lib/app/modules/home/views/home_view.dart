import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:notes/app/constants/exports.dart';
import 'package:notes/app/modules/home/Widgets/menu_screen.dart';
import 'package:notes/app/modules/settings/controllers/settings_controller.dart';
import 'package:notes/app/routes/app_pages.dart';
import '../Widgets/custom_floating_action_button.dart';
import '../Widgets/my_appbar.dart';
import '../Widgets/notes_grid.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settingsController = Get.find<SettingsController>();
    print('page is dark : ${settingsController.isDarkMode}');
    return FutureBuilder(
      future: controller.fetchNotes(),
      builder: (context, snapshot) => ZoomDrawer(
        style: DrawerStyle.defaultStyle,
        borderRadius: 24,
        isRtl: Get.locale! == const Locale('en') ? false : true,
        showShadow: true,
        angle: 0.0,
        mainScreenScale: 0.15,
        menuBackgroundColor: settingsController.isDarkMode
            ? ColorManager.drawerDark
            : ColorManager.drawerLight,
        drawerShadowsBackgroundColor: Colors.grey[300]!,
        slideWidth: MediaQuery.of(context).size.width * 0.65,
        menuScreen: const MenuScreen(),
        controller: controller.zoomDrawerController,
        mainScreen: MainScreen(controller: controller),
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    final settingsController = Get.find<SettingsController>();

    return CustomFloatingActionButton(
      options: [
        GestureDetector(
          child: CircleAvatar(
            backgroundColor: settingsController.isDarkMode
                ? ColorManager.appBarDark
                : ColorManager.appBarLight,
            child: Icon(
              Icons.text_fields,
              color: settingsController.isDarkMode
                  ? ColorManager.iconDark
                  : ColorManager.iconLight,
            ),
          ),
          onTap: () {
            Get.offNamed(Routes.ADD_NOTE);
          },
        ),
        GestureDetector(
          child: CircleAvatar(
              backgroundColor: settingsController.isDarkMode
                  ? ColorManager.appBarDark
                  : ColorManager.appBarLight,
              child: Icon(
                Icons.photo,
                color: settingsController.isDarkMode
                    ? ColorManager.iconDark
                    : ColorManager.iconLight,
              )),
          onTap: () {},
        ),
        GestureDetector(
          child: CircleAvatar(
              backgroundColor: settingsController.isDarkMode
                  ? ColorManager.appBarDark
                  : ColorManager.appBarLight,
              child: Icon(
                Icons.mic,
                color: settingsController.isDarkMode
                    ? ColorManager.iconDark
                    : ColorManager.iconLight,
              )),
          onTap: () {},
        ),
      ],
      type: CustomFloatingActionButtonType.circular,
      spaceFromRight: 20,
      backgroundColor: Colors.black54,
      openFloatingActionButton: Icon(
        Icons.add,
        size: 30.h,
        color: settingsController.isDarkMode
            ? ColorManager.iconDark
            : ColorManager.iconLight,
      ),
      closeFloatingActionButton: Icon(
        Icons.close,
        size: 30.h,
        color: settingsController.isDarkMode
            ? ColorManager.iconDark
            : ColorManager.iconLight,
      ),
      body: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const MyAppBar(),
            Expanded(
              // The Staggerred Tiles and Note Card widgets are built in the controller right after fetching the notes
              child: GetBuilder<HomeController>(
                builder: (c) => GetX<HomeController>(
                  builder: (controller) {
                    return NotesGrid(
                      crossAxis: controller.crossAxisCellCount.value,
                      cards: controller.cards,
                      tiles: controller.tiles,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
