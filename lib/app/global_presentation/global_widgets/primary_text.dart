import 'package:google_fonts/google_fonts.dart';

import '../../constants/exports.dart';

class PrimaryText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color? color;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final int maxLines;
  final bool lineThrow;
  final double height;

  const PrimaryText(
    this.text, {
    Key? key,
    this.fontSize = 13,
    this.color,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.visible,
    this.maxLines = 5,
    this.lineThrow = false,
    this.height = 1.5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
      color: color ?? ColorManager.fontColor,
      fontSize: (fontSize).sp,
      fontWeight: fontWeight,
      height: height,
      decoration: lineThrow ? TextDecoration.lineThrough : TextDecoration.none,
    );
    return Text(
      text.tr,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
      style: Get.locale!.languageCode != 'ar'
          ? GoogleFonts.poppins(textStyle: style)
          : GoogleFonts.tajawal(
              textStyle: style,
            ),
    );
  }
}
