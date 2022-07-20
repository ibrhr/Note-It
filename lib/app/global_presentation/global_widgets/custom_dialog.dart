import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

showMyDialog({
  required BuildContext context,
  required Widget content,
  bool isLong = false,
}) {
  var alert = BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10, tileMode: TileMode.mirror),
    child: Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 15.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.0)),
      backgroundColor: Colors.white,
      child: SizedBox(
        width: ScreenUtil().screenWidth - 30.w,
        height: isLong ? ScreenUtil().screenHeight - 80.h : null,
        child: content,
      ),
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
