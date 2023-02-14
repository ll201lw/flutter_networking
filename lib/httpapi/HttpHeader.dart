

import 'dart:collection';

import 'package:flutter_networking/constant/Constant.dart';

class HttpHeader{



  static Map<String,dynamic> headers(){
    Map<String,dynamic> map = HashMap();
    map["client_id"] = "telematicsApp";
    map["client_secret"] = "telematicsApp";
    map["Referer"] = Constant.networkUrl;
    return map;
  }
}