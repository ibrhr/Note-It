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
                  'Archived Notes',
                  fontSize: 18,
                ),
              ],
            ),
          ),
          Expanded(
            // The Staggerred Tiles and Note Card widgets are built in the controller right after fetching the notes
            child: GetBuilder<ArchivedController>(
              builder: (c) => GetX<ArchivedController>(
                builder: (controller) {
                  controller.prep();
                  var cards = controller.archivedCards;
                  var tiles = controller.archivedTiles;
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
