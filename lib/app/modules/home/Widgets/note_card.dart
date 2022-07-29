import 'package:notes/app/modules/add_note/views/add_note_view.dart';
import 'package:notes/app/modules/home/controllers/deleted_controller.dart';
import 'package:notes/app/modules/home/home_args.dart';
import 'package:notes/app/routes/app_pages.dart';

import '../../../constants/exports.dart';
import '../../../data/models/notes/note_model/note.dart';
import '../controllers/home_controller.dart';

class NoteCard extends GetView<HomeController> {
  const NoteCard({Key? key, required this.note}) : super(key: key);
  final Note note;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: key!,
      confirmDismiss: (dir) async => await Get.dialog(AlertDialog(
        content: PrimaryText(
          note.isDeleted!
              ? 'Are you sure you want to delete this note forever ?'
              : 'Are you sure you want to delete this note ?',
          fontSize: 16,
        ),
        actionsAlignment: MainAxisAlignment.spaceAround,
        actions: [
          ElevatedButton(
            onPressed: () => Get.back(result: true),
            child: const PrimaryText(
              'Yes',
              fontSize: 14,
              color: Colors.red,
            ),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: false),
            child: const PrimaryText(
              'No',
              fontSize: 14,
            ),
          ),
        ],
      )),
      onDismissed: (direction) => note.isDeleted!
          ? Get.find<DeletedController>().deleteNoteForever(note)
          : Get.find<HomeController>().deleteNote(note),
      background: Container(
        alignment: Alignment.centerLeft,
        child: const Icon(
          Icons.delete_outlined,
          size: 50,
          color: Colors.red,
        ),
      ),
      child: GestureDetector(
        onTap: () => Get.toNamed(Routes.ADD_NOTE,
            arguments:
                HomeArguments(screenType: NoteType.editNote, note: note)),
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: (note.color == null ||
                        Color(note.color!) == ColorManager.scaffoldDarkColor)
                    ? ColorManager.borderGrey
                    : ColorManager.scaffoldDarkColor,
              ),
              color: Color(note.color ?? ColorManager.scaffoldDarkColor.value)),
          child: Column(children: [
            note.image ?? Container(),
            note.title != null
                ? Container(
                    padding: const EdgeInsets.all(8),
                    child: PrimaryText(
                      note.title!,
                      fontSize: 15,
                    ))
                : Container(),
            note.text != null
                ? Container(
                    padding: const EdgeInsets.all(8),
                    child: PrimaryText(note.text!))
                : Container(),
          ]),
        ),
      ),
    );
  }
}
