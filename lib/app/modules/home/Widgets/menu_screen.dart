import 'package:notes/app/modules/home/controllers/home_controller.dart';
import 'package:notes/app/modules/home/views/deleted_view.dart';
import 'package:notes/app/modules/settings/controllers/settings_controller.dart';
import 'package:notes/app/modules/settings/views/settings_view.dart';
import '../../../constants/exports.dart';
import '../views/archived_view.dart';

class MenuScreen extends GetView<HomeController> {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.find<SettingsController>().isDarkMode
          ? ColorManager.drawerDark
          : ColorManager.drawerLight,
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              height: Get.mediaQuery.padding.top * 2,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                PrimaryText(
                  'Safe ',
                  fontSize: 26,
                  fontWeight: FontWeight.w400,
                  // color: Colors.indigo.shade400,
                ),
                PrimaryText(
                  'Note',
                  fontSize: 24,
                  //    color: Colors.indigo.shade300,
                )
              ],
            ),
            Expanded(
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ListTile(
                    leading: const Icon(Icons.lightbulb_outlined),
                    contentPadding: const EdgeInsets.all(16),
                    visualDensity: VisualDensity.compact,
                    title: PrimaryText(LocaleKeys.Notes.tr),
                    isThreeLine: false,
                    onTap: () => controller.closeDrawer(),
                  ),
                  ListTile(
                    leading: const Icon(Icons.archive_outlined),
                    contentPadding: const EdgeInsets.all(16),
                    visualDensity: VisualDensity.compact,
                    title: PrimaryText(LocaleKeys.Archive.tr),
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
                    title: PrimaryText(LocaleKeys.Deleted.tr),
                    isThreeLine: false,
                    onTap: () {
                      Get.to(() => const DeletedView());
                      controller.closeDrawer();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings_outlined),
                    contentPadding: const EdgeInsets.all(16),
                    visualDensity: VisualDensity.compact,
                    title: PrimaryText(LocaleKeys.Settings.tr),
                    isThreeLine: false,
                    onTap: () {
                      Get.to(() => const SettingsView());
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
