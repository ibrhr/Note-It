import 'package:notes/app/modules/add_note/views/add_note_view.dart';
import 'package:notes/app/modules/home/controllers/deleted_controller.dart';
import 'package:notes/app/modules/home/home_args.dart';
import 'package:notes/app/routes/app_pages.dart';

import '../../../constants/exports.dart';
import '../../../data/models/notes/note_model/note.dart';
import '../controllers/home_controller.dart';

class ReplicaNoteCard extends GetView<HomeController> {
  const ReplicaNoteCard({Key? key, required this.note}) : super(key: key);
  final Note note;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
      child: ListTile(
        leading: note.image,
        title: note.title != ''
            ? Container(
                padding: const EdgeInsets.all(8),
                child: PrimaryText(
                  note.title,
                  fontSize: 15,
                ))
            : null,
        subtitle: note.text != ''
            ? Container(
                padding: const EdgeInsets.all(8), child: PrimaryText(note.text))
            : null,
        onTap: () => Get.toNamed(Routes.ADD_NOTE,
            arguments:
                HomeArguments(screenType: NoteType.editNote, note: note)),
      ),
    );

    Container(
      margin: const EdgeInsets.all(8),
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
      child: Column(children: []),
    );
  }
}
