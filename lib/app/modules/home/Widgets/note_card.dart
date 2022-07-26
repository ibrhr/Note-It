import 'package:notes/app/modules/add_note/views/add_note_view.dart';
import 'package:notes/app/modules/home/home_args.dart';
import 'package:notes/app/routes/app_pages.dart';

import '../../../constants/exports.dart';
import '../../../data/models/note_model/note.dart';
import '../controllers/home_controller.dart';

class NoteCard extends GetView<HomeController> {
  const NoteCard({Key? key, required this.note}) : super(key: key);
  final Note note;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.ADD_NOTE,
              arguments:
                  HomeArguments(screenType: NoteType.editNote, note: note))!
          .then((value) => controller.addNote(value)),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: note.color == null
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
    );
  }
}
