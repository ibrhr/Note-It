import '../note_model/note.dart';

abstract class NoteRepo {
  Future<void> addNote(Note note);
  Future<void> deleteNote(Note note);
  Future<void> updateNote(int oldNoteID, Note newNote);
}
