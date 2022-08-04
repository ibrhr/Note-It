import 'package:image_picker/image_picker.dart';
import 'package:notes/app/modules/home/controllers/archived_controller.dart';
import 'package:notes/app/modules/home/controllers/deleted_controller.dart';
import 'package:notes/app/modules/home/controllers/home_controller.dart';
import 'package:notes/app/modules/settings/controllers/settings_controller.dart';
import '../../../constants/exports.dart';
import '../../../data/models/notes/note_model/note.dart';
import '../../../data/models/notes/repositories/note_repo_implement.dart';
import '../../../global_presentation/global_widgets/custom_snack_bar.dart';
import '../../home/home_args.dart';
import '../views/add_note_view.dart';
import 'dart:async';

class AddNoteController extends GetxController {
  @override
  void onInit() {
    recieveArgs();
    if (note != null) images = note!.images;
    super.onInit();
  }

  Rx<Color> color = Colors.transparent.obs;
  String? _image;

  List<String> images = [];

  final ImagePicker _picker = ImagePicker();

  final homeController = Get.find<HomeController>();
  final settingsController = Get.find<SettingsController>();

  var screenType = NoteType.addNote;

  Note? note;

  String? title;
  String? text;

  void updateColor(Color color) {
    this.color.value = color;
  }

  Future<void> pickImage() async {
    XFile? imagefile = await _picker.pickImage(source: ImageSource.gallery);
    if (imagefile != null) _image = imagefile.path;
    images.add(_image!);
    update();
  }

  Future<void> takeImage() async {
    XFile? imagefile = await _picker.pickImage(source: ImageSource.camera);
    if (imagefile != null) _image = imagefile.path;
    images.add(_image!);
    update();
  }

  void deleteImage(int index) {
    images.removeAt(index);
    save();
    update();
  }

  void recieveArgs() {
    if (Get.arguments != null) {
      final args = Get.arguments as HomeArguments;
      note = args.note;
      title = note!.title;
      text = note!.text;
      color.value = Color(note!.color!);
      screenType = NoteType.editNote;
    }
  }

  void saveAndExit() async {
    if ((title == null || title == '') &&
        (text == null || text == '') &&
        images.isEmpty) {
      if (note != null) {
        await Get.find<HomeController>().deleteNote(note!);
        await Get.find<DeletedController>().deleteNoteForever(note!);
      }
      Get.back();
      CustomSnackBar.showCustomToast(
        message: LocaleKeys.Empty_note_discarded.tr,
        duration: const Duration(milliseconds: 1500),
        color: settingsController.isDarkMode
            ? ColorManager.appBarDark
            : ColorManager.appBarLight,
      );
    } else if (screenType == NoteType.addNote) {
      note = Note(
        text: text ?? '',
        title: title ?? '',
        date: DateTime.now(),
        color: color.value.value,
        isArchived: false,
        images: images,
      );
      addNote();
      Get.back();
    } else if (!note!.isDeleted!) {
      note = Note(
        id: note!.id,
        images: images,
        text: text ?? '',
        title: title ?? '',
        date: DateTime.now(),
        color: color.value.value,
        isArchived: note!.isArchived,
      );
      updateNote();
      Get.back();
    } else {
      Get.back();
    }
  }

  void save() {
    if (title == null && text == null) {
      addNote();
      CustomSnackBar.showCustomToast(
        message: LocaleKeys.Note_Saved.tr,
        duration: const Duration(milliseconds: 1500),
        color: settingsController.isDarkMode
            ? ColorManager.appBarDark
            : ColorManager.appBarLight,
      );
    } else if (screenType == NoteType.addNote) {
      note = Note(
        text: text ?? '',
        title: title ?? '',
        date: DateTime.now(),
        color: color.value.value,
        isArchived: false,
        images: images,
      );
      addNote();
      screenType = NoteType.editNote;
      CustomSnackBar.showCustomToast(
        message: LocaleKeys.Note_Saved.tr,
        duration: const Duration(milliseconds: 1500),
        color: settingsController.isDarkMode
            ? ColorManager.appBarDark
            : ColorManager.appBarLight,
      );
    } else if (!note!.isDeleted!) {
      note = Note(
        id: note!.id,
        images: images,
        text: text ?? '',
        title: title ?? '',
        date: DateTime.now(),
        color: color.value.value,
        isArchived: note!.isArchived,
      );
      updateNote();
      CustomSnackBar.showCustomToast(
        message: LocaleKeys.Note_Updated.tr,
        duration: const Duration(milliseconds: 1500),
        color: settingsController.isDarkMode
            ? ColorManager.appBarDark
            : ColorManager.appBarLight,
      );
    }
  }

  Future<void> addNote() async {
    await NoteRepoImp().addNote(note!);
    await homeController.fetchNotes();
  }

  Future<void> updateNote() async {
    await NoteRepoImp().updateNote(note!.id!, note!);
    await homeController.fetchNotes();
    if (note!.isArchived == true) {
      Get.find<ArchivedController>().prep();
    }
  }

  Future<void> archiveNote() async {
    if (note == null) {
      CustomSnackBar.showCustomErrorToast(
        message: LocaleKeys.Note_must_be_created_before_it_can_be_archived.tr,
        duration: const Duration(milliseconds: 1500),
      );
    } else {
      note = Note(
        id: note!.id,
        images: note!.images,
        text: text ?? '',
        title: title ?? '',
        date: DateTime.now(),
        color: color.value.value,
        isArchived: note!.isArchived!,
      );
      await Get.find<ArchivedController>().archiveNote(note!);
      Get.back();
      CustomSnackBar.showCustomToast(
        message: note!.isArchived!
            ? LocaleKeys.Note_Unarchived.tr
            : LocaleKeys.Note_Archived.tr,
        duration: const Duration(seconds: 2),
        color: Get.find<SettingsController>().isDarkMode
            ? ColorManager.appBarDark
            : ColorManager.appBarLight,
      );
    }
  }
}
