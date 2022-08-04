import 'package:google_fonts/google_fonts.dart';
import 'package:notes/app/constants/exports.dart';

// import '../../generated/locales.g.dart';

class SearchTextField extends StatelessWidget {
     const SearchTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: ColorManager.primary,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: ColorManager.grey, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: ColorManager.grey, width: 1),
        ),
        prefixIcon: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 5.w,
          ),
          margin:
              EdgeInsets.only(right: 10.w, top: 1.h, bottom: 1.h, left: 1.w),
          decoration: BoxDecoration(
              color: ColorManager.grey4,
              borderRadius: BorderRadius.circular(8)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              items: [
                DropdownMenuItem(
                  child: PrimaryText(
                    "Name",
                    color: ColorManager.grey5,
                  ),
                ),
              ],
              onChanged: (String? value) {},
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        suffixIcon: Icon(
          Icons.search,
          color: ColorManager.primary,
        ),
        focusColor: ColorManager.primary,
        hoverColor: ColorManager.primary,
        hintText: 'search', // LocaleKeys.search.tr,
        hintStyle: Get.locale!.languageCode != 'ar'
            ? GoogleFonts.poppins(
                textStyle: TextStyle(color: ColorManager.grey, fontSize: 14.sp))
            : GoogleFonts.tajawal(
                textStyle: TextStyle(color: ColorManager.grey, fontSize: 14.sp),
              ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding:    const EdgeInsets.fromLTRB(15.0, 10.0, 20.0, 10.0),
      ),
    );
  }
}
