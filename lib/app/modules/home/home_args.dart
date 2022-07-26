import '../../data/models/note_model/note.dart';
import '../add_note/views/add_note_view.dart';

class HomeArguments {
  HomeArguments({required this.screenType, required this.note});
  NoteType screenType;
  Note note;
}
