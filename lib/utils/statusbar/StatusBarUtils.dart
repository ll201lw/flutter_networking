import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_networking/utils/color/ColorUtils.dart';


class StatusBarUtils{


  ///获取对应颜色color的style
  static SystemUiOverlayStyle getSysUiStyle(Color color){
    SystemUiOverlayStyle style =  SystemUiOverlayStyle(
      systemNavigationBarColor: color,
      statusBarColor: color,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark
    );
    return style;
  }


  /// 获取首页status style
  static SystemUiOverlayStyle getMainUiStyle(){
    return getSysUiStyle(ColorUtils.transparent);
  }

  ///设置首页status style
  static void setMainStyle(){
    SystemChrome.setSystemUIOverlayStyle(StatusBarUtils.getMainUiStyle());
  }


}