

class LoginEntity{
  String? access_token = "";
  String? token_type = "";
  String? refresh_token = "";
  int? expires_in = 0;
  String? scope = "";

  LoginEntity({this.access_token,this.token_type,this.refresh_token,this.expires_in,this.scope});

  factory LoginEntity.fromJson(Map<String,dynamic> json){
    LoginEntity loginEntity = LoginEntity();
    loginEntity.access_token = json["access_token"];
    loginEntity.token_type = json["token_type"];
    loginEntity.refresh_token = json["refresh_token"];
    loginEntity.expires_in = json["expires_in"];
    loginEntity.scope = json["scope"];
    return loginEntity;
  }
}