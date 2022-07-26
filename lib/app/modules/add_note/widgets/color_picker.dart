import 'package:fast_color_picker/fast_color_picker.dart';
import 'package:notes/app/constants/exports.dart';

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
          color: ColorManager.appBar),
      height: 90.h,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Padding(
          padding: EdgeInsets.only(top: 8, left: 8),
          child: PrimaryText('Color'),
        ),
        const SizedBox(height: 8),
        Expanded(child: FastColorPicker(onColorSelected: (color) {
          Get.back<Color>(result: color);
        })),
      ]),
    );
  }
}
