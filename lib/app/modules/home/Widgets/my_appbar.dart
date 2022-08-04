import 'package:notes/app/modules/home/Widgets/search_note_card.dart';
import 'package:notes/app/modules/home/controllers/home_controller.dart';
import 'package:search_page/search_page.dart';
import '../../../constants/exports.dart';
import '../../../data/models/notes/note_model/note.dart';
import '../../settings/controllers/settings_controller.dart';

class MyAppBar extends GetView<HomeController> {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).padding.top),
        InkWell(
          child: Container(
            width: Get.width,
            height: 50.w,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
                color: Get.find<SettingsController>().isDarkMode
                    ? ColorManager.appBarDark
                    : ColorManager.appBarLight,
                borderRadius: BorderRadius.all(Radius.circular(24.w))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => controller.toggleDrawer(),
                  icon: const Icon(
                    Icons.menu,
                  ),
                  splashRadius: 24.w,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => showSearch(
                      context: context,
                      delegate: SearchPage<Note>(
                          items: controller.notes.entries
                              .map((e) => e.value)
                              .toList(),
                          searchLabel: LocaleKeys.Search_notes.tr,
                          suggestion: Center(
                            child: PrimaryText(LocaleKeys.Search_notes.tr),
                          ),
                          failure: Center(
                            child: PrimaryText(LocaleKeys.No_notes_found.tr),
                          ),
                          filter: (note) => [
                                note.title,
                                note.text,
                              ],
                          builder: (note) {
                            return SearchNoteCard(
                              note: note,
                            );
                          }),
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(left: 8),
                      child: PrimaryText(
                        LocaleKeys.Search.tr,
                        color: Colors.white,
                        fontSize: 14.h,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => controller.changeCrossAxis(),
                  icon: GetBuilder<HomeController>(
                    builder: (controller) => Icon(
                      controller.crossAxisCellCount.value != 2
                          ? Icons.view_comfy_sharp
                          : Icons.view_agenda_outlined,
                    ),
                  ),
                  splashRadius: 24.w,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
