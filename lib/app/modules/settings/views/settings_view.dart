import 'package:note_it/app/constants/exports.dart';
import 'package:note_it/app/global_presentation/global_widgets/global_dailog.dart';
import 'package:note_it/app/modules/settings/controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
          Container(
            padding: const EdgeInsets.all(8),
            height: 50,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                  splashRadius: 22.w,
                ),
                const SizedBox(width: 16),
                PrimaryText(
                  LocaleKeys.Settings.tr,
                  fontSize: 18,
                ),
              ],
            ),
          ),
          Expanded(
              child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              ListTile(
                onTap: () async {
                  Get.dialog(
                    GlobalDialog(
                      title: 'Choose Theme',
                      details: ListView(
                        padding: const EdgeInsets.only(top: 16),
                        shrinkWrap: true,
                        children: [
                          RadioListTile(
                            value: 'dark',
                            groupValue: controller.theme,
                            onChanged: (val) async {
                              await controller.changeTheme(val as String);
                              Get.back();
                            },
                            title: PrimaryText(LocaleKeys.Dark.tr),
                          ),
                          RadioListTile(
                            value: 'light',
                            groupValue: controller.theme,
                            onChanged: (val) async {
                              await controller.changeTheme(val as String);
                              Get.back();
                            },
                            title: PrimaryText(LocaleKeys.Light.tr),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                leading: PrimaryText(
                  LocaleKeys.Theme.tr,
                  fontSize: 16,
                ),
                trailing: PrimaryText(
                  controller.theme == 'dark'
                      ? LocaleKeys.Dark.tr
                      : LocaleKeys.Light.tr,
                  fontSize: 15,
                ),
              ),
              ListTile(
                onTap: () {
                  Get.dialog(
                    GlobalDialog(
                      title: 'Choose Language',
                      details: ListView(
                        padding: const EdgeInsets.only(top: 16),
                        shrinkWrap: true,
                        children: [
                          RadioListTile(
                            value: 'ar',
                            groupValue: controller.language,
                            onChanged: (val) {
                              controller.changeLanguage(val as String);
                              Get.back();
                            },
                            title: PrimaryText(LocaleKeys.Arabic.tr),
                          ),
                          RadioListTile(
                            value: 'en',
                            groupValue: controller.language,
                            onChanged: (val) {
                              controller.changeLanguage(val as String);
                              Get.back();
                            },
                            title: PrimaryText(LocaleKeys.English.tr),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                leading: PrimaryText(
                  LocaleKeys.Language.tr,
                  fontSize: 16,
                ),
                trailing: PrimaryText(
                  controller.language == 'en'
                      ? LocaleKeys.English.tr
                      : LocaleKeys.Arabic.tr,
                  fontSize: 15,
                ),
              )
            ],
          )),
        ],
      ),
    );
  }
}
