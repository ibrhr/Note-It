import 'package:notes/app/constants/exports.dart';
import 'package:notes/app/modules/home/controllers/archived_controller.dart';
import 'package:notes/app/modules/home/controllers/home_controller.dart';
import '../Widgets/notes_grid.dart';

class ArchivedView extends GetView<ArchivedController> {
     const ArchivedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
          Container(
            padding:    const EdgeInsets.all(8),
            height: 50,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  icon:    const Icon(
                    Icons.arrow_back,
                  ),
                  splashRadius: 22.w,
                ),
                   const SizedBox(width: 16),
                 PrimaryText(
                  LocaleKeys.Archived_Notes.tr,
                  fontSize: 18,
                ),
              ],
            ),
          ),
          Expanded(
            child: GetX<ArchivedController>(
              builder: (controller) {
                // builds the widgets to be used
                controller.prep();
                return NotesGrid(
                  crossAxis:
                      Get.find<HomeController>().crossAxisCellCount.value,
                  cards: controller.archivedCards,
                  tiles: controller.archivedTiles,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
