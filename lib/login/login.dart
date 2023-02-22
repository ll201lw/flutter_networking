import 'dart:collection';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_networking/constant/Constant.dart';
import 'package:flutter_networking/httpapi/HttpApi.dart';
import 'package:flutter_networking/httpapi/HttpHeader.dart';
import 'package:flutter_networking/login/entity/LoginEntity.dart';
import 'package:flutter_networking/login/entity/PicCodeEntity.dart';
import 'package:flutter_networking/utils/aes/AesEncryptUtil.dart';
import 'package:flutter_networking/utils/color/ColorUtils.dart';
import 'package:flutter_networking/utils/dialog/DialogUtil.dart';
import 'package:flutter_networking/utils/dimensize/DimenSizeUtils.dart';
import 'package:flutter_networking/utils/reg/ValidatorUtil.dart';
import 'package:flutter_networking/utils/sp/SPUtils.dart';
import 'package:flutter_networking/utils/statusbar/StatusBarUtils.dart';

import '../home/home.dart';
import '../main/my_main.dart';
import '../network/http/DioUtils.dart';
import '../utils/toast/Toast.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  LoginState build(BuildContext context) {
    // Future.value((){
    //   SPUtils.init();
    // });
    return LoginState();
  }

  @override
  State<StatefulWidget> createState() => LoginState();
}

String? imageUuid = "";
Widget codeImage = Image.asset(
  "image/icon_close.png",
);

class LoginState extends State<LoginWidget> {
  final TextEditingController acountController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  var acountText = "13537581672";
  var passwordText = "123Qwe@";
  var codeText = "";
  var showClearButton = false;
  var showPassword = true;
  var codeUrl = "https://inews.gtimg.com/newsapp_bt/0/15663284187/1000";

  final Widget iconClearText = Image.asset(
    "image/icon_close.png",
    width: DimenSizeUtils.dimenSize_15,
    height: DimenSizeUtils.dimenSize_15,
  );
  final Widget iconEyeClose = Image.asset(
    "image/icon_eye_close.png",
    width: DimenSizeUtils.dimenSize_15,
    height: DimenSizeUtils.dimenSize_15,
  );
  final Widget iconEyeOpen = Image.asset(
    "image/icon_eye_open.png",
    width: DimenSizeUtils.dimenSize_15,
    height: DimenSizeUtils.dimenSize_15,
  );

  @override
  Widget build(BuildContext context) {
    if(mounted){
      acountController?.text = acountText;
      passwordController?.text = passwordText;
    }
    return Scaffold(
      key: UniqueKey(),
      resizeToAvoidBottomInset: false,
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          children: [
            SizedBox(height: DimenSizeUtils.getHeightDimens(90)),
            Row(
              children: [
                Container(
                  margin:
                      EdgeInsets.fromLTRB(DimenSizeUtils.dimenSize_30, 0, 0, 0),
                  child: Text('欢迎使用「',
                      style: TextStyle(
                          color: ColorUtils.black11,
                          fontSize: DimenSizeUtils.sp_25,
                          fontWeight: FontWeight.bold)),
                ),
                Text('车联网',
                    style: TextStyle(
                        color: ColorUtils.green2f,
                        fontSize: DimenSizeUtils.sp_25,
                        fontWeight: FontWeight.bold)),
                Text('」',
                    style: TextStyle(
                        color: ColorUtils.black11,
                        fontSize: DimenSizeUtils.sp_25,
                        fontWeight: FontWeight.bold))
              ],
            ),
            SizedBox(
              height: DimenSizeUtils.getHeightDimens(10),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(DimenSizeUtils.dimenSize_30, 0, 0, 0),
              child: Text('为农机主提供便捷的智能农机应用',
                  style: TextStyle(
                      color: ColorUtils.black11,
                      fontSize: DimenSizeUtils.sp_15)),
            ),
            SizedBox(
              height: DimenSizeUtils.getHeightDimens(100),
            ),
            Container(
              height: DimenSizeUtils.getHeightDimens(31),
              margin: EdgeInsets.fromLTRB(
                  DimenSizeUtils.dimenSize_30,
                  DimenSizeUtils.dimenSize_0,
                  DimenSizeUtils.dimenSize_30,
                  DimenSizeUtils.getHeightDimens(0)),
              child: TextField(
                controller: acountController,
                clipBehavior: Clip.none,
                decoration: InputDecoration(
                    hintText: '请输入用户名',
                    hintStyle: TextStyle(fontSize: DimenSizeUtils.sp_15),
                    enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: ColorUtils.greydd)),
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: ColorUtils.greydd)),
                    suffixIcon: showClearButton
                        ? IconButton(
                            padding: EdgeInsets.fromLTRB(
                                DimenSizeUtils.dimenSize_5,
                                0,
                                0,
                                DimenSizeUtils.dimenSize_13),
                            icon: iconClearText,
                            onPressed: () {
                              acountController.clear();
                              showClearButton =
                                  acountController.text.isNotEmpty;
                              setState(() {});
                            },
                          )
                        : null),
                style: TextStyle(
                    fontSize: DimenSizeUtils.sp_15, color: Colors.black),
                onChanged: (text) {
                  acountText = text;
                  showClearButton =
                      acountController.text.isNotEmpty ? true : false;
                  setState(() {});
                },
              ),
            ),
            SizedBox(
              height: DimenSizeUtils.getHeightDimens(39),
            ),
            Container(
              height: DimenSizeUtils.getHeightDimens(31),
              margin: EdgeInsets.fromLTRB(
                  DimenSizeUtils.dimenSize_30,
                  DimenSizeUtils.dimenSize_0,
                  DimenSizeUtils.dimenSize_30,
                  DimenSizeUtils.getHeightDimens(0)),
              child: TextField(
                controller: passwordController,
                clipBehavior: Clip.none,
                obscureText: showPassword,
                decoration: InputDecoration(
                    hintText: '请输入密码',
                    hintStyle: TextStyle(fontSize: DimenSizeUtils.sp_15),
                    enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: ColorUtils.greydd)),
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: ColorUtils.greydd)),
                    suffixIcon: IconButton(
                      padding: EdgeInsets.fromLTRB(DimenSizeUtils.dimenSize_5,
                          0, 0, DimenSizeUtils.dimenSize_13),
                      icon: showPassword ? iconEyeClose : iconEyeOpen,
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                    )),
                style: TextStyle(
                    fontSize: DimenSizeUtils.sp_15, color: Colors.black),
                onChanged: (text) {
                  passwordText = text;
                  showPassword =
                      passwordController.text.isNotEmpty ? true : false;
                },
              ),
            ),
            SizedBox(
              height: DimenSizeUtils.getHeightDimens(39),
            ),
            Container(
                height: DimenSizeUtils.getHeightDimens(35),
                margin: EdgeInsets.fromLTRB(
                    DimenSizeUtils.dimenSize_30,
                    DimenSizeUtils.dimenSize_0,
                    DimenSizeUtils.dimenSize_30,
                    DimenSizeUtils.getHeightDimens(0)),
                child: Stack(
                  children: [
                    TextField(
                      controller: codeController,
                      clipBehavior: Clip.none,
                      decoration: InputDecoration(
                        hintText: '请输入验证码',
                        hintStyle: TextStyle(fontSize: DimenSizeUtils.sp_15),
                        enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: ColorUtils.greydd)),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: ColorUtils.greydd)),
                        // icon: Image.network(codeUrl,fit: BoxFit.fill,),
                      ),
                      style: TextStyle(
                          fontSize: DimenSizeUtils.sp_15, color: Colors.black),
                      onChanged: (text) {
                        codeText = text;
                      },
                    ),
                    Positioned(
                      right: 3,
                      bottom: 5,
                      width: 100,
                      child: IconButton(
                        onPressed: () {
                          changeCodeImage(context, setState);
                        },
                        icon: codeImage,
                      ),
                    )
                  ],
                )),
            Container(
              height: DimenSizeUtils.getHeightDimens(46),
              margin: EdgeInsets.fromLTRB(DimenSizeUtils.dimenSize_30,
                  DimenSizeUtils.dimenSize_49, DimenSizeUtils.dimenSize_30, 0),
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(DimenSizeUtils.dimenSize_8)),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: ColorUtils.green2f),
                onPressed: () {
                  var acount = acountController.value;
                  var password = acountController.value;
                  var code = acountController.value;

                  if ("" == acountText) {
                    Toast.showToast(context, "请输入账号");
                    return;
                  }

                  if (!ValidatorUtil.isAccount(acountText)) {
                    Toast.showToast(context, "请输入有效用户名(用户名为1-8位字母、数字或文字组成)");
                    return;
                  }

                  if ("" == passwordText) {
                    Toast.showToast(context, "请输入密码");
                    return;
                  }

                  if (!ValidatorUtil.isPassword(passwordText)) {
                    Toast.showToast(context, "请输入密码(6-20位字母数字组合)");
                    return;
                  }

                  if ("" == codeText) {
                    Toast.showToast(context, "请输入验证码");
                    return;
                  }

                  if (acount.text.isNotEmpty &&
                      password.text.isNotEmpty &&
                      code.text.isNotEmpty) {
                    DialogUtil.show(context, "加载中...");
                    login(context, acountText, passwordText, codeText,
                        imageUuid!);
                  }
                },
                child: Center(
                  child: Text(
                    '登录',
                    style: TextStyle(
                        fontSize: DimenSizeUtils.sp_16,
                        color: ColorUtils.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    Future.value(() {
      SPUtils.init();
    });
    super.initState();
    StatusBarUtils.setMainStyle();
    changeCodeImage(context, setState);
  }
}

Widget getImage(BuildContext context, PicCodeEntity entity) {
  return Image.memory(base64.decoder.convert(entity.img!.split(',')[1]));
}

///修改验证码图片
void changeCodeImage(BuildContext context, Function setState) {
  DioUtils.instacne.requestNetwork(Method.get, HttpApi.getPath(HttpApi.picCode),
      header: HttpHeader.headers(), onSuccess: (data) {
    var entity = PicCodeEntity.fromJson(data as Map<String, dynamic>);
    setState(() {
      imageUuid = entity.uuid;
      codeImage = getImage(context, entity);
    });
  }, onError: (t, value) {
    Toast.showToast(context, "$t $value");
  });
}

void login(BuildContext context, String username, String password, String code,
    String uuid) async {
  String mPassword = await AesEncryptUtil.encrypt(password);
  Map<String, dynamic> params = HashMap();
  params['username'] = username;
  params['password'] = mPassword;
  params['code'] = code;
  params['uuid'] = uuid;
  DioUtils.instacne.requestNetwork(Method.post, HttpApi.getPath(HttpApi.login),
      params: params, onSuccess: (data) {
    LoginEntity loginEntity =
        LoginEntity.fromJson(data as Map<String, dynamic>);
    if (null != loginEntity) {
      //获取token
      Constant.tokenValue = loginEntity.access_token!;
      Constant.refreshTokenValue = loginEntity.refresh_token!;
      //存储username和password
      SPUtils.setString(Constant.username, username);
      SPUtils.setString(Constant.password, password);
      //存储token
      SPUtils.setString(Constant.token, loginEntity.access_token);
      SPUtils.setString(Constant.refresh_token, loginEntity.refresh_token);
      print("${loginEntity.access_token} ${loginEntity.access_token}");
    }
    //关闭加载框
    DialogUtil.dismiss(context);
    //跳转到主页
    pushMain(context,const HomePage());
  }, onError: (code, message) {
    DialogUtil.dismiss(context);
    Toast.showToast(context, message);
  });
}

///跳转到首页
void pushMain(BuildContext context,Widget widget) {
  Navigator.push(
    context,
    CupertinoPageRoute(builder: (_) => widget),
  );
}

class TopContentWidget extends StatelessWidget {
  const TopContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
