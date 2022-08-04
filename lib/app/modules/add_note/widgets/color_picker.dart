import 'package:fast_color_picker/fast_color_picker.dart';
import 'package:notes/app/constants/exports.dart';
import 'package:notes/app/modules/settings/controllers/settings_controller.dart';

class ColorPicker extends StatelessWidget {
  const ColorPicker({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
        color: Get.find<SettingsController>().isDarkMode
            ? ColorManager.appBarDark
            : ColorManager.appBarLight,
      ),
      height: 90.h,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.only(top: 8, left: 8),
          child: PrimaryText(LocaleKeys.Color.tr),
        ),
        const SizedBox(height: 8),
        Expanded(child: FastColorPicker(onColorSelected: (color) {
          Get.back<Color>(result: color);
        })),
      ]),
    );
  }
}
