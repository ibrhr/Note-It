import 'package:note_it/app/modules/home/controllers/home_controller.dart';
import 'package:note_it/app/modules/home/views/deleted_view.dart';
import 'package:note_it/app/modules/settings/controllers/settings_controller.dart';
import 'package:note_it/app/modules/settings/views/settings_view.dart';
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
              textDirection: TextDirection.ltr,
              children: const [
                PrimaryText(
                  'Note ',
                  fontSize: 26,
                  fontWeight: FontWeight.w400,
                  // color: Colors.indigo.shade400,
                ),
                PrimaryText(
                  'It',
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
                    title: PrimaryText(
                      LocaleKeys.Notes.tr,
                      textAlign: TextAlign.center,
                    ),
                    isThreeLine: false,
                    onTap: () => controller.closeDrawer(),
                  ),
                  ListTile(
                    leading: const Icon(Icons.archive_outlined),
                    contentPadding: const EdgeInsets.all(16),
                    visualDensity: VisualDensity.compact,
                    title: PrimaryText(
                      LocaleKeys.Archive.tr,
                      textAlign: TextAlign.center,
                    ),
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
                    title: PrimaryText(
                      LocaleKeys.Deleted.tr,
                      textAlign: TextAlign.center,
                    ),
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
                    title: PrimaryText(
                      LocaleKeys.Settings.tr,
                      textAlign: TextAlign.center,
                    ),
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
