import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// import 'package:fluttertoast/fluttertoast.dart';

enum ToastPosition { TOP, CENTER, BOTTOM }

class Toast {
  static void showToast(
    //显示文本
    String msg
  ) async {
    assert(msg != null);
    // Fluttertoast.showToast(msg: msg,backgroundColor: ColorUtils.black11,textColor: ColorUtils.white,webPosition: "center");
  }
}
