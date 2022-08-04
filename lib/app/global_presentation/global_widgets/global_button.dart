import '../../constants/exports.dart';

class GlobalButton extends StatelessWidget {
     const GlobalButton({
    Key? key,
    this.onTap,
    this.selected,
    this.isSkip = false,
    this.icon,
    required this.title,
    this.color,
    this.borderColor,
    this.width,
    this.height,
  }) : super(key: key);

  final GestureTapCallback? onTap;
  final double? width, height;
  final Icon? icon;
  final String title;
  final bool? selected, isSkip;
  final Color? color, borderColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? 80.w,
        height: height ?? 35.h,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
              width: 1,
              color: (selected != null)
                  ? ((selected! == false)
                      ? ColorManager.grey
                      : borderColor ?? ColorManager.accent)
                  : borderColor ?? ColorManager.accent),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PrimaryText(
              title,
              color: (selected != null)
                  ? ((selected! == false)
                      ? ColorManager.grey5
                      : borderColor ?? ColorManager.accent)
                  : ColorManager.primary,
              fontSize: 15,
            ),
            Visibility(
              visible: (selected != null && selected!),
              child: Row(
                children: [
                  SizedBox(width: 15.w),
                  icon ??    const SizedBox(),
                ],
              ),
            ),
            Visibility(
              visible: (isSkip!),
              child: Row(
                children: [
                  SizedBox(width: 5.w),
                  icon ??    const SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
