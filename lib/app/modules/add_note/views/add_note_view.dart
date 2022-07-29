import 'package:notes/app/constants/exports.dart';
import 'package:notes/app/modules/home/home_args.dart';
import '../../../data/models/notes/note_model/note.dart';
import '../../../global_presentation/global_widgets/custom_snack_bar.dart';
import '../controllers/add_note_controller.dart';
import '../widgets/add_note_bottom_sheet.dart';

enum NoteType { editNote, addNote }

class AddNoteView extends GetView<AddNoteController> {
  const AddNoteView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const TextStyle titleStyle = TextStyle(fontSize: 24);
    const TextStyle textStyle = TextStyle(fontSize: 16);

    String? title;
    String? text;

    var screenType = NoteType.addNote;

    Note? note;

    // Determining Screen type
    if (Get.arguments != null) {
      final args = Get.arguments as HomeArguments;
      note = args.note;
      title = note.title;
      text = note.text;
      controller.color.value = Color(note.color!);
      screenType = NoteType.editNote;
    }

    return GetX<AddNoteController>(
      builder: (controller) {
        var color = controller.color.value;
        return Scaffold(
          backgroundColor: color,
          appBar: AppBar(
            backgroundColor: color,
            automaticallyImplyLeading: false,
            leading: IconButton(
                onPressed: () {
                  if (title == null && text == null) {
                    Get.back();
                    CustomSnackBar.showCustomToast(
                      message: 'Empty note discarded',
                      duration: const Duration(seconds: 2),
                      color: ColorManager.appBar,
                    );
                  } else if (screenType == NoteType.addNote) {
                    final newNote = Note(
                        text: text,
                        title: title,
                        date: DateTime.now(),
                        color: color.value,
                        isArchived: false);
                    controller.addNote(newNote);
                    Get.back();
                  } else if (screenType == NoteType.editNote &&
                      !note!.isDeleted! &&
                      !note.isArchived!) {
                    final newNote = Note(
                      id: note.id,
                      image: note.image,
                      text: text,
                      title: title,
                      date: DateTime.now(),
                      color: color.value,
                      isArchived: note.isArchived,
                    );
                    controller.updateNote(note.id!, newNote);
                    Get.back();
                  } else {
                    Get.back();
                  }
                },
                icon: const Icon(Icons.arrow_back)),
            actions: [
              IconButton(
                  onPressed: () {
                    if (note == null) {
                    } else {
                      controller.archiveNote(note);
                      Get.back();
                      CustomSnackBar.showCustomToast(
                        message: note.isArchived!
                            ? 'Note Unarchived'
                            : 'Note Archived',
                        duration: const Duration(seconds: 2),
                        color: ColorManager.appBar,
                      );
                    }
                  },
                  icon: Icon(note == null
                      ? Icons.archive_outlined
                      : (note.isArchived!
                          ? Icons.unarchive_outlined
                          : Icons.archive_outlined)))
            ],
          ),
          body: Container(
            padding: const EdgeInsets.all(8),
            child: Form(
              child: Column(
                children: [
                  TextFormField(
                    style: titleStyle,
                    maxLines: null,
                    initialValue: title,
                    onChanged: (value) => title = value,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Title',
                      hintStyle: titleStyle,
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      style: textStyle,
                      initialValue: text,
                      onChanged: (value) => text = value,
                      maxLines: null,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Text',
                        hintStyle: textStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomSheet: AddNoteBottomSheet(note: note),
        );
      },
    );
  }
}
