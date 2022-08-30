import 'package:note_it/app/constants/exports.dart';
import 'package:note_it/app/modules/settings/controllers/settings_controller.dart';



AppBar globalAppBar({String? title, List<Widget>? actions, Widget? leading}) {
  return AppBar(
    centerTitle: true,
    backgroundColor: ColorManager.white,
    elevation: 0,
    toolbarHeight: 90.h,
    title: title != null
        ? PrimaryText(
            title,
            fontSize: 21,
            color: ColorManager.primary,
        //    fontWeight: FontWeightManager.medium,
          )
        : const SizedBox(),
    leading: leading ??
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            height: 60.h,
            width: 60.w,
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
    actions: actions ?? [],
  );
}
