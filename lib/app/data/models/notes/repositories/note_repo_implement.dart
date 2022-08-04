import 'package:deep_collection/deep_collection.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/app/data/models/notes/note_model/note.dart';
import 'package:notes/app/data/models/notes/repositories/note_repo.dart';

class NoteRepoImp implements NoteRepo {
  final box = Hive.box('notes');

  static Map<int, Note> notes = {};
  static Map<int, Note> archived = {};
  static Map<int, Note> deleted = {};

  @override
  Future<void> fetchNotes() async {
    notes.clear();
    archived.clear();
    deleted.clear();
    final length = box.length;
    for (var i = 0; i < length; i++) {
      final tempNote = await box.getAt(i) as Note;
      final note = Note(
        id: i,
        color: tempNote.color,
        title: tempNote.title,
        text: tempNote.text,
        date: tempNote.date,
        images: tempNote.images,
        isArchived: tempNote.isArchived,
        isDeleted: tempNote.isDeleted,
      );
      if (!tempNote.isDeleted!) {
        if (!tempNote.isArchived!) {
          notes[note.id!] = note;
        } else {
          archived[note.id!] = note;
        }
      } else {
        deleted[note.id!] = note;
      }
    }
    notes = DeepMap(notes).deepReverse();
    deleted = DeepMap(deleted).deepReverse();
    archived = DeepMap(archived).deepReverse();
  }

  @override
  Future<void> addNote(Note note) async {
    await box.add(note);
  }

  @override
  Future<void> deleteNoteForever(Note note) async {
    await box.deleteAt(note.id!);
  }

  @override
  Future<void> updateNote(int oldNoteId, Note newNote) async {
    await box.putAt(oldNoteId, newNote);
  }

  @override
  Future<void> deleteNote(Note note) async {
    Note newNote = Note(
        color: note.color,
        date: note.date,
        images: note.images,
        isArchived: note.isArchived,
        text: note.text,
        title: note.title,
        isDeleted: true);
    await updateNote(note.id!, newNote);
  }

  @override
  Future<void> archiveNote(Note note) async {
    Note newNote = Note(
        color: note.color,
        date: note.date,
        images: note.images,
        isArchived: !note.isArchived!,
        text: note.text,
        title: note.title,
        isDeleted: note.isDeleted);
    await updateNote(note.id!, newNote);
  }

  @override
  Future<void> restoreNote(Note note) async {
    Note newNote = Note(
        color: note.color,
        date: note.date,
        images: note.images,
        isArchived: note.isArchived,
        text: note.text,
        title: note.title,
        isDeleted: false);
    await updateNote(note.id!, newNote);
  }
}
