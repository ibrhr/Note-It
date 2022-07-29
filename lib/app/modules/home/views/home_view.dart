import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:notes/app/constants/exports.dart';
import 'package:notes/app/modules/home/Widgets/menu_screen.dart';
import 'package:notes/app/routes/app_pages.dart';
import '../Widgets/custom_floating_action_button.dart';
import '../Widgets/my_appbar.dart';
import '../Widgets/notes_grid.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.fetchNotes(),
      builder: (context, snapshot) => ZoomDrawer(
        style: DrawerStyle.defaultStyle,
        borderRadius: 24,
        showShadow: true,
        angle: 0.0,
        mainScreenScale: 0.15,
        menuBackgroundColor: ColorManager.appBar,
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
    return CustomFloatingActionButton(
      options: [
        GestureDetector(
          child: CircleAvatar(
            backgroundColor: ColorManager.appBar,
            child: Icon(
              Icons.text_fields,
              color: ColorManager.icon,
            ),
          ),
          onTap: () {
            Get.offNamed(Routes.ADD_NOTE);
          },
        ),
        GestureDetector(
          child: CircleAvatar(
              backgroundColor: ColorManager.appBar,
              child: Icon(
                Icons.photo,
                color: ColorManager.icon,
              )),
          onTap: () {},
        ),
        GestureDetector(
          child: CircleAvatar(
              backgroundColor: ColorManager.appBar,
              child: Icon(
                Icons.mic,
                color: ColorManager.icon,
              )),
          onTap: () {},
        ),
      ],
      type: CustomFloatingActionButtonType.circular,
      spaceFromRight: 20,
      floatinButtonColor: ColorManager.appBar,
      // spaceFromBottom: 20,
      openFloatingActionButton: const Icon(Icons.add, size: 30),
      closeFloatingActionButton: const Icon(Icons.close, size: 30),
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
                    var cards = controller.cards;
                    var tiles = controller.tiles;
                    return NotesGrid(
                      crossAxis: controller.crossAxisCellCount.value,
                      cards: cards,
                      tiles: tiles,
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
