import '../note_model/note.dart';

abstract class NoteRepo {
  int get nextId;
  Future<void> fetchNotes();
  Future<void> addNote(Note note);
  Future<void> archiveNote(Note note);
  Future<void> deleteNote(Note note);
  Future<void> restoreNote(Note note);

  Future<void> deleteNoteForever(Note note);
  Future<void> updateNote(int oldNoteID, Note newNote);
}
