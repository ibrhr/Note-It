import 'package:flutter/cupertino.dart';

import '../../constants/exports.dart';

Future<dynamic> showLoadingDialog() {
  return Get.dialog(
    Container(
        color: ColorManager.black.withOpacity(0.4),
        height: 140.h,
        width: 140.w,
        child: Center(
          child: Container(
            height: 80.h,
            width: 80.w,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: CupertinoActivityIndicator(
                animating: true,
                radius: 20.h,
              ),
            ),
          ),
        )),
  );
}
