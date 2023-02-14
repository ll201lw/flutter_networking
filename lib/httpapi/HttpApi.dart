class HttpApi {
  static const String addApp = '/api-app/';

  ///登录模块
  static const String picCode =
      'api-telematics-app/v1/loginmanager/oauth/capatch';
  static const String login =
      'api-telematics-app/v1/loginmanager/oauth/telematicsClient/token';

  static String getPath(String url) {
    return addApp + url;
  }
}
