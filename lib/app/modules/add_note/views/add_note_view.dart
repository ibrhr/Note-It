import 'package:focused_menu/modals.dart';
import 'package:intl/intl.dart';
import 'package:notes/app/constants/exports.dart';
import 'package:notes/app/modules/home/home_args.dart';
import '../../../data/models/note_model/note.dart';
import '../../../global_presentation/global_widgets/custom_snack_bar.dart';
import '../controllers/add_note_controller.dart';
import '../widgets/color_picker.dart';
import '../widgets/my_focused_menu_holder.dart';

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

    if (Get.arguments != null) {
      final args = Get.arguments as HomeArguments;
      note = args.note;
      title = args.note.title;
      text = args.note.text;
      controller.color.value = Color(args.note.color!);
      screenType = args.screenType;
    }

    return GetX<AddNoteController>(
      builder: (controller) => Scaffold(
        backgroundColor: controller.color.value,
        appBar: AppBar(
          backgroundColor: controller.color.value,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                if (title == null && text == null) {
                  Get.back();
                  CustomSnackBar.showCustomToast(
                    message: 'Empty note discarded',
                    duration: const Duration(seconds: 1),
                    color: ColorManager.appBar,
                  );
                } else if (screenType == NoteType.addNote) {
                  Get.back<Note>(
                      result: Note(
                    text: text,
                    title: title,
                    date: DateTime.now(),
                    color: controller.color.value.value,
                  ));
                } else {
                  Get.back<Note>(
                      result: Note(
                    id: note!.id,
                    image: note.image,
                    text: text,
                    title: title,
                    date: DateTime.now(),
                    color: controller.color.value.value,
                  ));
                }
              },
              icon: const Icon(Icons.arrow_back)),
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.archive_outlined))
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
        bottomSheet: Container(
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
                      'Edited   ${DateFormat.Md().format(DateTime.now())}'),
                ),
                const CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.transparent,
                ),
                MyFocusedMenuHolder(items: [
                  FocusedMenuItem(
                      backgroundColor: ColorManager.appBar,
                      title: const PrimaryText("Make a copy"),
                      trailingIcon: const Icon(Icons.copy_outlined),
                      onPressed: () {}),
                  FocusedMenuItem(
                      backgroundColor: ColorManager.appBar,
                      title: const PrimaryText("Delete", color: Colors.red),
                      trailingIcon:
                          const Icon(Icons.delete_outlined, color: Colors.red),
                      onPressed: () {}),
                ], child: const Icon(Icons.more_vert)),
              ],
            )),
      ),
    );
  }
}
