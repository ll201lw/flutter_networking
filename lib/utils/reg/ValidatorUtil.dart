

class ValidatorUtil{
  static String regexAccount = "^[(a-zA-Z0-9\\u4e00-\\u9fa5){1}_#]{5,20}\$";
  static String regexPassword = "^(?![0-9]+\$)(?![^0-9]+\$)(?![a-zA-Z]+\$)(?![^a-zA-Z]+\$)(?![a-zA-Z0-9]+\$)[a-zA-Z0-9\\S]{6,}\$";




  ///校验账号
  static bool isAccount(String account){
    return RegExp(regexAccount).hasMatch(account);
  }

  ///校验密码
  static bool isPassword(String password){
    return RegExp(regexPassword).hasMatch(password);
  }

}