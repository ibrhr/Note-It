import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/app/data/models/note_model/note.dart';
import 'package:notes/app/data/models/repositories/note_repo.dart';

class NoteRepoImp implements NoteRepo {
  final box = Hive.box('notes');

  final List<Note> notes = [];

  @override
  Future<void> addNote(Note note) async {
    print('adding');
    print(note.id);
    if (note.id == null) {
      await box.add(note);
    } else {
      print('updating');
      updateNote(note.id!, note);
    }
  }

  @override
  Future<void> deleteNote(Note note) async {
    await box.deleteAt(note.id!);
  }

  @override
  Future<void> updateNote(int oldNoteId, Note newNote) async {
    await box.putAt(oldNoteId, newNote);
  }
}
