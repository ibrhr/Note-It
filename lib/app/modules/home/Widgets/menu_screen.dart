import 'package:notes/app/modules/home/controllers/home_controller.dart';
import 'package:notes/app/modules/home/views/deleted_view.dart';
import '../../../constants/exports.dart';
import '../views/archived_view.dart';

class MenuScreen extends GetView<HomeController> {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.appBar,
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              height: Get.mediaQuery.padding.top * 2,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                PrimaryText(
                  'Safe ',
                  fontSize: 26,
                  fontWeight: FontWeight.w400,
                  color: Colors.indigo.shade400,
                ),
                PrimaryText(
                  'Note',
                  fontSize: 24,
                  color: Colors.indigo.shade300,
                )
              ],
            ),
            Expanded(
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  const ListTile(
                    leading: Icon(Icons.lightbulb_outlined),
                    contentPadding: EdgeInsets.all(16),
                    visualDensity: VisualDensity.compact,
                    title: PrimaryText('Notes'),
                    isThreeLine: false,
                    //  onTap: () => Get.off(() => const HomeView()),
                  ),
                  ListTile(
                    leading: const Icon(Icons.archive_outlined),
                    contentPadding: const EdgeInsets.all(16),
                    visualDensity: VisualDensity.compact,
                    title: const PrimaryText('Archive'),
                    isThreeLine: false,
                    onTap: () {
                      Get.to(() => const ArchivedView());
                      controller.closeDrawer();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.delete_outline),
                    contentPadding: const EdgeInsets.all(16),
                    visualDensity: VisualDensity.compact,
                    title: const PrimaryText('Deleted'),
                    isThreeLine: false,
                    onTap: () {
                      Get.to(() => const DeletedView());
                      controller.closeDrawer();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
