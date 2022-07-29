import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:notes/app/data/models/notes/note_model/note.dart';
import '../../../constants/exports.dart';
import '../../../data/models/notes/repositories/note_repo_implement.dart';
import '../Widgets/note_card.dart';
import 'home_controller.dart';

class DeletedController extends GetxController {
  Map<int, Note> get deleted => NoteRepoImp.deleted.obs;

  final homeController = Get.find<HomeController>();

  var deletedTiles = <StaggeredTile>[].obs;
  var deletedCards = <NoteCard>[].obs;

  void prep() {
    print('deleted : $deleted');
    deletedTiles.clear();
    deletedCards.clear();
    deleted.forEach((key, note) {
      deletedTiles.add(const StaggeredTile.fit(1));
      deletedCards.add(NoteCard(
        key: ValueKey<int>(note.id!),
        note: note,
      ));
    });
  }

  Future<void> restoreNote(Note note) async {
    deleted.remove(note.id);
    await NoteRepoImp().restoreNote(note);
    await homeController.fetchNotes();
    prep();
  }

  Future<void> deleteNoteForever(Note note) async {
    deleted.remove(note.id!);
    await NoteRepoImp().deleteNoteForever(note);
    await homeController.fetchNotes();
    prep();
  }
}
