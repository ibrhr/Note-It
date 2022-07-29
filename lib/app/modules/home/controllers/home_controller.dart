import 'package:flutter_zoom_drawer/config.dart';
import 'package:hive/hive.dart';
import 'package:notes/app/data/models/notes/note_model/note.dart';
import 'package:notes/app/data/models/prefs/prefs_repo_imp.dart';
import 'package:notes/app/modules/home/controllers/archived_controller.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import '../../../constants/exports.dart';
import '../../../data/models/notes/repositories/note_repo_implement.dart';
import '../Widgets/note_card.dart';

class HomeController extends GetxController {
  //// Drawer

  final zoomDrawerController = ZoomDrawerController();

  void toggleDrawer() {
    zoomDrawerController.toggle?.call();
    update();
  }

  void closeDrawer() {
    zoomDrawerController.close?.call();
  }

  //// End of Drawer

  Map<int, Note> get notes => NoteRepoImp.notes.obs;

  var tiles = <StaggeredTile>[].obs;
  var cards = <NoteCard>[].obs;

  var crossAxisCellCount = PrefsRepoImp.crossAxis.obs;

  Future<void> fetchNotes() async {
    tiles.clear();
    cards.clear();
    await NoteRepoImp().fetchNotes();
    print(notes);
    notes.forEach((key, note) {
      tiles.add(const StaggeredTile.fit(1));
      cards.add(NoteCard(
        key: ValueKey<int>(note.id!),
        note: note,
      ));
    });

    update();
  }

  Future<void> deleteNote(Note note) async {
    if (note.isArchived!) {
      Get.find<ArchivedController>().archived.remove(note.id!);
    } else {
      notes.remove(note.id!);
    }
    await NoteRepoImp().deleteNote(note);
    await fetchNotes();
  }

  void changeCrossAxis() {
    PrefsRepoImp().changeCrossAxis();
    crossAxisCellCount = PrefsRepoImp.crossAxis.obs;
    update();
  }

  @override
  void onClose() {
    Hive.close();
    super.onClose();
  }
}
