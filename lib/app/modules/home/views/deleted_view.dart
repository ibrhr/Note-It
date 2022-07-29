import 'package:notes/app/constants/exports.dart';
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
            padding: const EdgeInsets.all(8),
            height: 50,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(
                    Icons.arrow_back,
                    size: 22.w,
                  ),
                  splashRadius: 22.w,
                ),
                const SizedBox(width: 16),
                const PrimaryText(
                  'Deleted Notes',
                  fontSize: 18,
                ),
              ],
            ),
          ),
          Expanded(
            // The Staggerred Tiles and Note Card widgets are built in the controller right after fetching the notes
            child: GetBuilder<DeletedController>(
              builder: (c) => GetX<DeletedController>(
                builder: (controller) {
                  controller.prep();
                  var cards = controller.deletedCards;
                  var tiles = controller.deletedTiles;
                  return NotesGrid(
                    crossAxis:
                        Get.find<HomeController>().crossAxisCellCount.value,
                    cards: cards,
                    tiles: tiles,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
