import 'package:focused_menu/modals.dart';
import 'package:intl/intl.dart';
import 'package:note_it/app/modules/settings/controllers/settings_controller.dart';

import '../../../constants/exports.dart';
import '../../../data/models/notes/note_model/note.dart';
import '../../home/controllers/deleted_controller.dart';
import '../controllers/add_note_controller.dart';
import '../views/add_note_view.dart';
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
    final bool isDeleted = controller.screenType == NoteType.editNote &&
        controller.note!.isDeleted == true;
    final settingsController = Get.find<SettingsController>();
    return Container(
        height: 55.h,
        padding: const EdgeInsets.all(8),
        color: controller.color.value == Colors.transparent
            ? Get.theme.backgroundColor
            : controller.color.value,
        child: Row(
          children: [
            !isDeleted
                ? MyFocusedMenuHolder(items: [
                    FocusedMenuItem(
                        backgroundColor: settingsController.isDarkMode
                            ? ColorManager.appBarDark
                            : ColorManager.appBarLight,
                        title: PrimaryText(LocaleKeys.Take_photo.tr),
                        trailingIcon: const Icon(Icons.camera_alt_outlined),
                        onPressed: () {
                          controller.takeImage();
                        }),
                    FocusedMenuItem(
                        backgroundColor: settingsController.isDarkMode
                            ? ColorManager.appBarDark
                            : ColorManager.appBarLight,
                        title: PrimaryText(LocaleKeys.Add_image.tr),
                        trailingIcon: const Icon(Icons.image_outlined),
                        onPressed: () {
                          controller.pickImage();
                        }),
                  ], child: const Icon(Icons.add_box_outlined))
                : Icon(
                    Icons.add_box_outlined,
                    color: Get.theme.disabledColor,
                  ),
            const SizedBox(width: 8),
            IconButton(
                onPressed: !isDeleted
                    ? () => Get.bottomSheet(const ColorPicker()).then((value) {
                          if (value != null) controller.updateColor(value);
                        })
                    : null,
                icon: const Icon(Icons.color_lens)),
            Expanded(
              child: PrimaryText(
                  textAlign: TextAlign.center,
                  '${LocaleKeys.Edited.tr}  ${DateFormat.Md().format(note == null ? DateTime.now() : note!.date)}'),
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
                        backgroundColor: settingsController.isDarkMode
                            ? ColorManager.appBarDark
                            : ColorManager.appBarLight,
                        title: PrimaryText(
                          LocaleKeys.Restore.tr,
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
                        backgroundColor: settingsController.isDarkMode
                            ? ColorManager.appBarDark
                            : ColorManager.appBarLight,
                        title: PrimaryText(LocaleKeys.Delete_Forever.tr,
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
