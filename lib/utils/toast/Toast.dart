import 'package:flutter_networking/utils/color/ColorUtils.dart';
import 'package:fluttertoast/fluttertoast.dart';


class Toast {
  static void showToast(
    //显示文本
    String msg
  ) async {
    assert(msg != null);
    Fluttertoast.showToast(msg: msg,backgroundColor: ColorUtils.greydd,textColor: ColorUtils.black11,gravity: ToastGravity.CENTER,webPosition: "center");
  }
}
