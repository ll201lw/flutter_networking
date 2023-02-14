import 'package:flutter/material.dart';
import 'package:flutter_networking/utils/dialog/custom/customLoading/LoadingDialog.dart';


class DialogUtil{

  static LoadingDialog? loadingDialog;

  static show(BuildContext context,String text){
    return showDialog(context: context,barrierDismissible: false, builder: (BuildContext context){
      if(null== loadingDialog) {
        return LoadingDialog(text: text);
      }
      return loadingDialog!;
    });
  }

  static dismiss(BuildContext context){
    Navigator.pop(context);
    loadingDialog = null;
  }

}