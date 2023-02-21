import 'package:flutter_networking/constant/Constant.dart';

class ImagePathUtil {
  static const String pathTag = "/hxdfs";

  static String getImagePath(String path) {
    String url = "";
    url = Constant.networkUrl + pathTag + path;
    return url;
  }
}
