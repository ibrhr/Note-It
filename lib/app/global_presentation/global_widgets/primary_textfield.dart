import 'package:google_fonts/google_fonts.dart';

import '../../constants/exports.dart';
// import '../../generated/locales.g.dart';

class PrimaryTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final Function(String)? onFieldSubmitted;
  final bool readOnly;
  final bool? multiLines;
  final TextInputAction? textInputAction;
  final String title;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final FocusNode? focusNode;
  final double leftOrRightPadding;
  final int noOfLines;

     const PrimaryTextField({
    Key? key,
    this.hintText,
    required this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.focusNode,
    this.onTap,
    this.focusedBorder,
    this.noOfLines = 10,
    this.enabledBorder,
    this.readOnly = false,
    this.onFieldSubmitted,
    this.suffixIcon,
    this.multiLines = false,
    this.leftOrRightPadding = 0,
    this.textInputAction = TextInputAction.none,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle hintStyle = TextStyle(color: ColorManager.grey, fontSize: 14.sp);
    TextStyle style = TextStyle(
        color: (readOnly) ? ColorManager.grey5 : ColorManager.fontColor2);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PrimaryText(
          title,
          color: ColorManager.grey3,
        ),
        SizedBox(height: 5.h),
        Container(
          decoration: BoxDecoration(
            borderRadius:    const BorderRadius.all(Radius.circular(8.0)),
            color: ColorManager.white,
          ),
          child: TextFormField(
            focusNode: focusNode,
            controller: controller,
            readOnly: readOnly,
            textInputAction: textInputAction,
            maxLines: multiLines! ? noOfLines : 1,
            cursorColor: ColorManager.fontColor,
            style: Get.locale!.languageCode != 'ar'
                ? GoogleFonts.poppins(textStyle: style)
                : GoogleFonts.tajawal(
                    textStyle: style,
                  ),
            keyboardType: keyboardType,
            onTap: onTap ?? () {},
            onFieldSubmitted: onFieldSubmitted ?? (String value) {},
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon != null
                  ? Padding(
                      padding: EdgeInsets.only(
                        right: Get.locale ==    const Locale("en") ? 8.w : 0.0,
                        left: Get.locale ==    const Locale("ar") ? 8.w : 0.0,
                      ),
                      child: prefixIcon,
                    )
                  : null,
              focusColor: ColorManager.primary,
              prefixIconConstraints: BoxConstraints(
                minWidth: 25.w,
              ),
              suffixIconConstraints:BoxConstraints(
                minWidth: 25.w,
              ),
              focusedBorder: focusedBorder,
              enabledBorder: enabledBorder,
              hoverColor: ColorManager.primary,
              hintText: hintText ?? "",
              hintStyle: Get.locale!.languageCode != 'ar'
                  ? GoogleFonts.poppins(textStyle: hintStyle)
                  : GoogleFonts.tajawal(
                      textStyle: hintStyle,
                    ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: ColorManager.grey),
              ),
              contentPadding: EdgeInsets.only(
                top: Get.locale !=    const Locale("ar")
                    ? (multiLines!)
                        ? 20.h
                        : 2.h
                    : 8.h,
                left: Get.locale !=    const Locale("ar")
                    ? leftOrRightPadding.h
                    : 0.h,
                right: Get.locale !=    const Locale("ar")
                    ? 0.h
                    : leftOrRightPadding.h,
              ),
            ),
            validator: validator ??
                (String? value) {
                  if (value!.length < 6) {
                    return 'LocaleKeys.invalid_password.tr';
                  }
                  return null;
                },
          ),
        ),
      ],
    );
  }
}
