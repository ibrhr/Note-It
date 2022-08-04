import 'dart:developer';

import '../../constants/exports.dart';
import '../../modules/home/controllers/home_controller.dart';
import '../../modules/settings/controllers/settings_controller.dart';

class CustomAppBar extends GetView<HomeController> {
     const CustomAppBar({
    Key? key,
    this.title,
    this.leading,
    this.action,
    required bool centerTitle,
  }) : super(key: key);

  final Widget? title;
  final Widget? leading, action;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).padding.top),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            leading ??
                GestureDetector(
                  onTap: () {
                    log("clicked");
                    Get.back();
                  },
                  child: Container(
                    height: 50.h,
                    width: 50.w,
                    decoration: BoxDecoration(
                        color: ColorManager.grey6, shape: BoxShape.circle),
                    child: Icon(
                      Icons.arrow_back_rounded,
                      color: (Get.find<SettingsController>().isDarkMode)
                          ? ColorManager.white
                          : ColorManager.black.withOpacity(0.7),
                    ),
                  ),
                ),
            title ?? Container(),
            action ??    const Text(""),
          ],
        ),
      ],
    );
  }
}
