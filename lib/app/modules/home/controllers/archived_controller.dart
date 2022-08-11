import 'package:note_it/app/modules/home/controllers/home_controller.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:note_it/app/data/models/notes/note_model/note.dart';
import '../../../constants/exports.dart';
import '../../../data/models/notes/repositories/note_repo_implement.dart';
import '../Widgets/note_card.dart';

class ArchivedController extends GetxController {
  Map<int, Note> get archived => NoteRepoImp.archived.obs;

  final homeController = Get.find<HomeController>();

  var archivedTiles = <StaggeredTile>[].obs;
  var archivedCards = <NoteCard>[].obs;

  void prep() {
    archivedTiles.clear();
    archivedCards.clear();
    archived.forEach((key, note) {
      archivedTiles.add(   const StaggeredTile.fit(1));
      archivedCards.add(NoteCard(
        key: ValueKey<int>(note.id!),
        note: note,
      ));
    });
    
  }

  Future<void> archiveNote(Note note) async {
    await NoteRepoImp().archiveNote(note);
    await homeController.fetchNotes();
    prep();
    update();
  }
}
