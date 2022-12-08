import 'package:flutter/material.dart';
import 'package:flutter_networking/utils/color/ColorUtils.dart';
import 'package:flutter_networking/utils/dimensize/DimenSizeUtils.dart';

import '../main/my_main.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  LoginState build(BuildContext context) {

    return LoginState();
  }

  @override
  State<StatefulWidget> createState()=>LoginState();
}

class LoginState extends State<LoginWidget>{
  final TextEditingController acountController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  var acountText = "";
  var passwordText = "";
  var codeText = "";
  var showClearButton = false;
  var showPassword = true;
  var codeUrl = "";


  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
              height: DimenSizeUtils.getHeightDimens(21),
              margin: EdgeInsets.fromLTRB(
                  DimenSizeUtils.dimenSize_30,
                  DimenSizeUtils.dimenSize_0,
                  DimenSizeUtils.dimenSize_30,
                  DimenSizeUtils.getHeightDimens(10)),
              child: TextField(
                controller: acountController,
                clipBehavior: Clip.none,
                decoration: InputDecoration(
                    hintText: '请输入用户名',
                    hintStyle: TextStyle(fontSize: DimenSizeUtils.sp_15),
                    suffixIcon: showClearButton?IconButton(
                      padding: EdgeInsets.fromLTRB(
                          DimenSizeUtils.dimenSize_5, 0, 0, DimenSizeUtils.dimenSize_13),
                      icon:  Icon(
                        Icons.cancel,
                        size: DimenSizeUtils.dimenSize_15,
                      ),
                      onPressed: () {
                        acountController.clear();
                        showClearButton = acountController.text.isNotEmpty;
                        setState(() {
                        });
                      },
                    ):null
                ),
                style: TextStyle(fontSize: DimenSizeUtils.sp_15),
                onChanged: (text) {
                  acountText = text;
                  showClearButton = acountController.text.isNotEmpty?true:false;
                  setState(() {
                  });
                },
              ),
            ),
            SizedBox(
              height: DimenSizeUtils.getHeightDimens(39),
            ),
            Container(
              height: DimenSizeUtils.getHeightDimens(21),
              margin: EdgeInsets.fromLTRB(
                  DimenSizeUtils.dimenSize_30,
                  DimenSizeUtils.dimenSize_0,
                  DimenSizeUtils.dimenSize_30,
                  DimenSizeUtils.getHeightDimens(10)),
              child: TextField(
                controller: passwordController,
                clipBehavior: Clip.none,
                obscureText: showPassword,
                decoration: InputDecoration(
                  hintText: '请输入密码',
                  hintStyle: TextStyle(fontSize: DimenSizeUtils.sp_15),
                  suffixIcon: IconButton(
                    padding: EdgeInsets.fromLTRB(
                        DimenSizeUtils.dimenSize_5, 0, 0, DimenSizeUtils.dimenSize_13),
                    icon:  Icon(
                      showPassword?Icons.visibility:Icons.visibility_off,
                      size: DimenSizeUtils.dimenSize_15,
                    ),
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                  )
                ),
                style: TextStyle(fontSize: DimenSizeUtils.sp_15),
                onChanged: (text) {
                  passwordText = text;
                  showPassword = passwordController.text.isNotEmpty?true:false;
                },
              ),
            ),
            SizedBox(
              height: DimenSizeUtils.getHeightDimens(39),
            ),
            Container(
              height: DimenSizeUtils.getHeightDimens(21),
              margin: EdgeInsets.fromLTRB(
                  DimenSizeUtils.dimenSize_30,
                  DimenSizeUtils.dimenSize_0,
                  DimenSizeUtils.dimenSize_30,
                  DimenSizeUtils.getHeightDimens(10)),
              child: TextField(
                controller: codeController,
                clipBehavior: Clip.none,
                decoration: InputDecoration(
                    hintText: '请输入验证码',
                    hintStyle: TextStyle(fontSize: DimenSizeUtils.sp_15),
                  // icon: Image.network(codeUrl,fit: BoxFit.fill,),
                ),
                style: TextStyle(fontSize: DimenSizeUtils.sp_15),
                onChanged: (text) {
                  codeText = text;
                },
              ),
            ),
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
                    // Toast.showToast("请输入账号");
                    return;
                  }

                  if ("" == passwordText) {
                    // Toast.showToast("请输入密码");
                    return;
                  }
                  if ("" == codeText) {
                    // Toast.showToast("请输入验证码");
                    return;
                  }

                  if (null != acount && null != password && null != code) {
                    pushMain(context);
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

}

void pushMain(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const RandomWords()),
  );
}

class TopContentWidget extends StatelessWidget {
  const TopContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
