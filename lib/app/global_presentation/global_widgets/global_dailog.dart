import 'package:notes/app/constants/exports.dart';

class GlobalDialog extends StatelessWidget {
  final String title;
  final String details;
  const GlobalDialog({Key? key, required this.title, required this.details})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 30.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PrimaryText(
              title,
              color: ColorManager.primary,
              fontSize: 20,
              fontWeight: FontWeightManager.medium,
            ),
            SizedBox(height: 10.h),
            PrimaryText(
              details,
              color: ColorManager.grey2,
              fontSize: 16,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            PrimaryButton(
              width: 142.w,
              onPressed: () => Get.back(),
              title: 'ok', //LocaleKeys.ok.tr,
            )
          ],
        ),
      ),
    );
  }
}
