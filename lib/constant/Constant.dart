

class Constant{

  ///正式环境
  // static const String networkUrl = 'https://smart.farmbgy.com';
  ///测试环境
  static const String networkUrl = 'https://smart-sit.farmbgy.com';

  ///websocket
  static const String websocketBaseUrl = "wss://smart-sit.farmbgy.com";
  static const String websocketPath = "/socket/websocket-server/ws/asset?auth-type=hx-ykdj-front";

  static const String code = 'status';
  static const String message = 'message';
  static const String data = 'result';

  static const String username = "username";
  static const String password = "password";

  static const String refresh_token = "refresh_token";

  static const String  authorization = "Authorization";
  static const String  bearer = "Bearer ";
  static const String  token = "token";

  static String tokenValue = '';
  static String refreshTokenValue = '';
  static String tokenLoginOutValue = '';


  static String getWebSocketTokenString(String tokenValue){
    return "&$token=$tokenValue";
  }

}