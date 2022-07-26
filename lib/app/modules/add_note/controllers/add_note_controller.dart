import 'package:notes/app/data/models/repositories/note_repo_implement.dart';

import '../../../constants/exports.dart';
import '../../../data/models/note_model/note.dart';

class AddNoteController extends GetxController {
  Rx<Color> color = ColorManager.scaffoldDarkColor.obs;

  void updateColor(Color color) {
    this.color.value = color;
  }

  Future<void> addNote(Note note) async {
    await NoteRepoImp().addNote(note);
  }

  Future<void> deleteNote(Note note) async {
    await NoteRepoImp().deleteNote(note);
  }

  Future<void> updateNote(int oldNoteId, Note newNote) async {
    await NoteRepoImp().updateNote(oldNoteId, newNote);
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
