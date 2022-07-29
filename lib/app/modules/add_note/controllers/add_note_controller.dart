import 'package:notes/app/modules/home/controllers/archived_controller.dart';
import 'package:notes/app/modules/home/controllers/home_controller.dart';
import '../../../constants/exports.dart';
import '../../../data/models/notes/note_model/note.dart';
import '../../../data/models/notes/repositories/note_repo_implement.dart';

class AddNoteController extends GetxController {
  Rx<Color> color = ColorManager.scaffoldDarkColor.obs;

  final homeController = Get.find<HomeController>();

  void updateColor(Color color) {
    this.color.value = color;
  }

  Future<void> addNote(Note note) async {
    await NoteRepoImp().addNote(note);
    await homeController.fetchNotes();
  }

 

  Future<void> updateNote(int oldNoteId, Note newNote) async {
    await NoteRepoImp().updateNote(oldNoteId, newNote);
    await homeController.fetchNotes();
  }

  Future<void> archiveNote(Note note) async {
    await Get.find<ArchivedController>().archiveNote(note);
  }
}
