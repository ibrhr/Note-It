import 'dart:io';

import 'package:note_it/app/constants/exports.dart';
import '../../settings/controllers/settings_controller.dart';
import '../controllers/add_note_controller.dart';
import '../widgets/add_note_bottom_sheet.dart';

enum NoteType { editNote, addNote, addImage, takeImage }

class AddNoteView extends GetView<AddNoteController> {
  const AddNoteView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = TextStyle(
        fontSize: 24.w,
        color: Get.find<SettingsController>().isDarkMode
            ? Colors.white
            : ColorManager.black);
    TextStyle textStyle = TextStyle(
        fontSize: 16.w,
        color: Get.find<SettingsController>().isDarkMode
            ? Colors.white
            : ColorManager.black);
    final bool isDeleted = controller.screenType == NoteType.editNote &&
        controller.note!.isDeleted == true;

    return WillPopScope(
      onWillPop: () async {
        controller.saveAndExit();
        return true;
      },
      child: GetX<AddNoteController>(
        builder: (controller) {
          var color = controller.color.value;
          final iconColor = Get.find<SettingsController>().isDarkMode
              ? Colors.white
              : ColorManager.black;
          return Scaffold(
            backgroundColor:
                color == Colors.transparent ? Get.theme.backgroundColor : color,
            appBar: AppBar(
              backgroundColor: color,
              automaticallyImplyLeading: false,
              leading: IconButton(
                  onPressed: () {
                    controller.saveAndExit();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: iconColor,
                  )),
              actions: [
                !isDeleted || controller.note == null
                    ? IconButton(
                        onPressed: () {
                          controller.save();
                        },
                        icon: Icon(
                          Icons.save_alt_outlined,
                          color: iconColor,
                        ),
                      )
                    : Container(),
                IconButton(
                  onPressed: () async {
                    await controller.archiveNote();
                  },
                  icon: Icon(
                    controller.note == null
                        ? Icons.archive_outlined
                        : (controller.note!.isArchived!
                            ? Icons.unarchive_outlined
                            : Icons.archive_outlined),
                    color: iconColor,
                  ),
                ),
              ],
            ),
            body: Container(
              margin: EdgeInsets.only(
                bottom: 55.h,
              ),
              child: Form(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GetBuilder<AddNoteController>(builder: (controller) {
                        return controller.images.isNotEmpty
                            ? ConstrainedBox(
                                constraints: BoxConstraints.loose(
                                  Size(Get.width, Get.height - 300.h),
                                ),
                                child: ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(width: 5),
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: controller.images.length,
                                  itemBuilder: (context, i) => InkWell(
                                    onLongPress: () async =>
                                        await Get.dialog(const Dialog()).then(
                                            (value) => value
                                                ? controller.deleteImage(i)
                                                : null),
                                    child: Image.file(
                                      File(controller.images[i]),
                                      fit: BoxFit.contain,
                                      height: 100,
                                    ),
                                  ),
                                ),
                              )
                            : Container();
                      }),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: TextFormField(
                          enabled: !isDeleted,
                          style: titleStyle,
                          maxLines: null,
                          initialValue: controller.title,
                          onChanged: (value) => controller.title = value,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: LocaleKeys.Title.tr,
                            hintStyle: titleStyle,
                          ),
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            enabled: !isDeleted,
                            style: textStyle,
                            initialValue: controller.text,
                            onChanged: (value) => controller.text = value,
                            maxLines: null,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: LocaleKeys.Text.tr,
                              hintStyle: textStyle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottomSheet: AddNoteBottomSheet(note: controller.note),
          );
        },
      ),
    );
  }
}

class Dialog extends StatelessWidget {
  const Dialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: PrimaryText(
        LocaleKeys.Delete_Image.tr,
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
    );
  }
}
