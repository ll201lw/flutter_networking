import 'package:flutter_networking/constant/Constant.dart';

class ImagePathUtil {
  static const String pathTag = "/hxdfs";

  static String getImagePath(String path) {
    String url = "";
    if(null!=path) {
      if(path.contains(pathTag)){
        url = Constant.networkUrl+path;
      }else {
        url = Constant.networkUrl + pathTag + path;
      }
    }
    return url;
  }
}
