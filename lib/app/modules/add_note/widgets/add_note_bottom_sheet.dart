import 'package:focused_menu/modals.dart';
import 'package:intl/intl.dart';

import '../../../constants/exports.dart';
import '../../../data/models/notes/note_model/note.dart';
import '../../home/controllers/deleted_controller.dart';
import '../controllers/add_note_controller.dart';
import 'color_picker.dart';
import 'my_focused_menu_holder.dart';

class AddNoteBottomSheet extends GetView<AddNoteController> {
  const AddNoteBottomSheet({
    Key? key,
    required this.note,
  }) : super(key: key);

  final Note? note;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            MyFocusedMenuHolder(items: [
              FocusedMenuItem(
                  backgroundColor: ColorManager.appBar,
                  title: const PrimaryText("Take photo"),
                  trailingIcon: const Icon(Icons.camera_alt_outlined),
                  onPressed: () {}),
              FocusedMenuItem(
                  backgroundColor: ColorManager.appBar,
                  title: const PrimaryText("Add image"),
                  trailingIcon: const Icon(Icons.image_outlined),
                  onPressed: () {}),
              FocusedMenuItem(
                  backgroundColor: ColorManager.appBar,
                  title: const PrimaryText("Recording"),
                  trailingIcon: const Icon(Icons.mic_none),
                  onPressed: () {}),
            ], child: const Icon(Icons.add_box_outlined)),
            IconButton(
                onPressed: () =>
                    Get.bottomSheet(const ColorPicker()).then((value) {
                      if (value != null) controller.updateColor(value);
                    }),
                icon: const Icon(Icons.color_lens)),
            Expanded(
              child: PrimaryText(
                  textAlign: TextAlign.center,
                  'Edited   ${DateFormat.Md().format(note == null ? DateTime.now() : note!.date!)}'),
            ),
            const CircleAvatar(
              radius: 24,
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.transparent,
            ),
            note != null && note!.isDeleted!
                ? MyFocusedMenuHolder(
                    items: [
                      FocusedMenuItem(
                        backgroundColor: ColorManager.appBar,
                        title: const PrimaryText(
                          "Restore",
                        ),
                        trailingIcon: const Icon(
                          Icons.restore_outlined,
                        ),
                        onPressed: () {
                          Get.find<DeletedController>().restoreNote(note!);
                          Get.back();
                        },
                      ),
                      FocusedMenuItem(
                        backgroundColor: ColorManager.appBar,
                        title: const PrimaryText("Delete Forever",
                            color: Colors.red),
                        trailingIcon: const Icon(Icons.delete_outlined,
                            color: Colors.red),
                        onPressed: () {
                          Get.find<DeletedController>()
                              .deleteNoteForever(note!);
                          Get.back();
                        },
                      ),
                    ],
                    child: const Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                  )
                : Icon(Icons.more_vert, color: Colors.white.withOpacity(0.2)),
          ],
        ));
  }
}
