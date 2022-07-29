import 'package:notes/app/modules/home/Widgets/note_card.dart';
import 'package:notes/app/modules/home/Widgets/replica_note_card.dart';
import 'package:notes/app/modules/home/controllers/home_controller.dart';
import 'package:search_page/search_page.dart';

import '../../../constants/exports.dart';
import '../../../data/models/notes/note_model/note.dart';

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
                color: ColorManager.appBar,
                borderRadius: BorderRadius.all(Radius.circular(24.w))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => controller.toggleDrawer(),
                  icon: Icon(
                    Icons.menu,
                    size: 24.w,
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
                          searchLabel: 'Search notes',
                          suggestion: const Center(
                            child: Text('Search notes'),
                          ),
                          failure: const Center(
                            child: Text('No notes found :('),
                          ),
                          filter: (note) => [
                                note.title,
                                note.text,
                              ],
                          builder: (note) {
                            return ReplicaNoteCard(
                              note: note,
                            );
                          }),
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(left: 8),
                      child: PrimaryText(
                        'Search',
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
                      size: 24.w,
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
