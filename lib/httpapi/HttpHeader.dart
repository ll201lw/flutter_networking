

import 'dart:collection';

import 'package:flutter_networking/constant/Constant.dart';

class HttpHeader{



  static Map<String,dynamic> headers(){
    Map<String,dynamic> map = HashMap();
    map["client_id"] = "telematicsApp";
    map["client_secret"] = "telematicsApp";
    map["Referer"] = Constant.networkUrl;
    if(Constant.tokenValue!=null&&"" != Constant.tokenValue){
      map[Constant.authorization] = "${Constant.bearer}${Constant.tokenValue}";
    }
    return map;
  }
}