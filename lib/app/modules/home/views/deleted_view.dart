import 'package:note_it/app/constants/exports.dart';
import '../Widgets/notes_grid.dart';
import '../controllers/deleted_controller.dart';
import '../controllers/home_controller.dart';

class DeletedView extends GetView<DeletedController> {
     const DeletedView({Key? key}) : super(key: key);

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
                  LocaleKeys.Deleted_Notes.tr,
                  fontSize: 18,
                ),
              ],
            ),
          ),
          Expanded(
            // The Staggerred Tiles and Note Card widgets are built in the controller right after fetching the notes
            child: GetX<DeletedController>(
              builder: (controller) {
                controller.prep();
                return NotesGrid(
                  crossAxis:
                      Get.find<HomeController>().crossAxisCellCount.value,
                  cards: controller.deletedCards,
                  tiles: controller.deletedTiles,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
