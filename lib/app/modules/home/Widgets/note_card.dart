import 'dart:io';

import 'package:notes/app/modules/add_note/views/add_note_view.dart';
import 'package:notes/app/modules/home/controllers/deleted_controller.dart';
import 'package:notes/app/modules/home/home_args.dart';
import 'package:notes/app/modules/settings/controllers/settings_controller.dart';
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
              ? LocaleKeys.confirm_forever.tr
              : LocaleKeys.confirm.tr,
          fontSize: 16,
        ),
        actionsAlignment: MainAxisAlignment.spaceAround,
        actions: [
          ElevatedButton(
            onPressed: () => Get.back(result: true),
            child: PrimaryText(
              LocaleKeys.Yes.tr,
              fontSize: 14,
              color: Colors.red,
            ),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: false),
            child: PrimaryText(
              LocaleKeys.No.tr,
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
        onTap: () =>
            // note.isDeleted!
            //      ? null
            //   :
            Get.toNamed(Routes.ADD_NOTE,
                arguments:
                    HomeArguments(screenType: NoteType.editNote, note: note)),
        child: Container(
          margin: const EdgeInsets.all(8),
          //   padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: (note.color == null ||
                        Color(note.color!) == Colors.transparent)
                    ? ColorManager.borderGrey
                    : Get.find<SettingsController>().isDarkMode
                        ? ColorManager.scaffoldDarkColor
                        : ColorManager.scaffoldLightColor,
              ),
              color: Color(note.color ?? Colors.transparent.value)),
          child: Column(children: [
            note.images.isNotEmpty
                ? ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16)),
                    child: Image.file(File(note.images[0])))
                : Container(),
            note.title != ''
                ? Container(
                    padding: const EdgeInsets.all(8),
                    child: PrimaryText(
                      note.title,
                      fontSize: 15,
                    ))
                : (note.text == ''
                    // if both title and text are empty, to give the widget a proper shape
                    ? Container(
                        padding: const EdgeInsets.all(8),
                        child: const PrimaryText(
                          '',
                          fontSize: 15,
                        ))
                    : Container()),
            note.text != ''
                ? Container(
                    padding: const EdgeInsets.all(8),
                    child: PrimaryText(note.text))
                : Container(),
          ]),
        ),
      ),
    );
  }
}
