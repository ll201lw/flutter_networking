import 'package:flutter/cupertino.dart';
import 'package:flutter_networking/utils/color/ColorUtils.dart';
import 'package:flutter_networking/utils/toast/ToastUtil.dart';
import 'package:fluttertoast/fluttertoast.dart';


class Toast {
  static void showToast(
      BuildContext context,
    //显示文本
    String msg
  ) async {
    assert(msg != null);
    ToastUtil.showToast(context, msg);
    // Fluttertoast.showToast(msg: msg,backgroundColor: ColorUtils.greydd,textColor: ColorUtils.black11,gravity: ToastGravity.CENTER,webPosition: "center");
  }
}
