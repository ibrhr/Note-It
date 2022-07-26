import 'package:hive/hive.dart';
import 'package:notes/app/data/models/note_model/note.dart';
import '../../../constants/exports.dart';
import '../../../data/models/repositories/note_repo_implement.dart';

class HomeController extends GetxController {
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
    Hive.openBox('notes');
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    Hive.close();
    super.onClose();
  }
}
