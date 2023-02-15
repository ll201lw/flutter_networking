import 'package:encrypt/encrypt.dart';



class AesEncryptUtil{

  static String keys = "2858310341595137";
  static String ivs = "2890256383840258";

  static String encrypt(String plainText) {
    final key = Key.fromUtf8(keys);
    final iv = IV.fromUtf8(ivs);
    final encrypter = Encrypter(AES(key,mode: AESMode.cbc));
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return encrypted.base64.toString();
  }


}