import 'package:notes/app/constants/exports.dart';
import 'package:notes/app/data/models/note_model/note.dart';
import 'package:notes/app/routes/app_pages.dart';
import '../Widgets/custom_floating_action_button.dart';
import '../Widgets/my_appbar.dart';
import '../controllers/home_controller.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/app/modules/home/Widgets/note_card.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

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
            Get.offNamed(Routes.ADD_NOTE)!
                .then((value) => controller.addNote(value));
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
                child: ValueListenableBuilder<Box>(
                    valueListenable: Hive.box('notes').listenable(),
                    builder: (listenerContext, box, widget) {
                      final box = Hive.box('notes');
                      final length = box.length;
                      final List<StaggeredTile> tiles = [];
                      final List<NoteCard> cards = [];
                      for (var i = 0; i < length; i++) {
                        final tempNote = box.getAt(i) as Note;
                        final note = Note(
                            id: i,
                            color: tempNote.color,
                            title: tempNote.title,
                            text: tempNote.text,
                            date: tempNote.date,
                            image: tempNote.image);
                        tiles.add(const StaggeredTile.fit(2));
                        cards.add(NoteCard(
                          note: note,
                        ));
                      }
                      return StaggeredGridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 4,
                        staggeredTiles: tiles,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        padding: const EdgeInsets.all(4),
                        children: cards,
                      );
                    })),
          ],
        ),
      ),
    );
  }
}
