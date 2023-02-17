import 'package:flutter/material.dart';
import 'package:flutter_networking/utils/dimensize/DimenSizeUtils.dart';

class LoadingDialog extends Dialog {
  final String text;

  const LoadingDialog({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(DimenSizeUtils.dimenSize_8),
        decoration: BoxDecoration(
            color: Colors.black45,
            borderRadius:
                BorderRadius.all(Radius.circular(DimenSizeUtils.dimenSize_5))),
        width: DimenSizeUtils.dimenSize_60,
        height: DimenSizeUtils.dimenSize_60,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: DimenSizeUtils.dimenSize_3,
              ),
              SizedBox(
                width: DimenSizeUtils.dimenSize_20,
                height: DimenSizeUtils.dimenSize_20,
                child: const CircularProgressIndicator(
                  strokeWidth: 3,
                  backgroundColor: Colors.white,
                ),
              ),
              SizedBox(
                height: DimenSizeUtils.dimenSize_6,
              ),
              Material(
                color: Colors.transparent,
                child: Text(
                  text,
                  maxLines: 1,
                  style: TextStyle(
                      backgroundColor: Colors.transparent,
                      color: Colors.white,
                      fontSize: DimenSizeUtils.sp_10,),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
