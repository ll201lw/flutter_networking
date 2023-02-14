import 'package:flutter/material.dart';
import 'package:flutter_networking/utils/dimensize/DimenSizeUtils.dart';

class LoadingDialog extends Dialog{
  final String text;
  const LoadingDialog({Key?key,required this.text}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(DimenSizeUtils.dimenSize_8),
        decoration: BoxDecoration(
          color: Colors.black45,
          borderRadius: BorderRadius.all(Radius.circular(DimenSizeUtils.dimenSize_5))
        ),
        width: DimenSizeUtils.dimenSize_50,
        height: DimenSizeUtils.dimenSize_50,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const CircularProgressIndicator(backgroundColor: Colors.white,),
              SizedBox(height: DimenSizeUtils.dimenSize_6,),
              Material(
                color: Colors.transparent,
                child: Text(text,style: TextStyle(backgroundColor: Colors.transparent,color: Colors.white,fontSize: DimenSizeUtils.sp_12),),),
            ],
          ),
        ),
      ),
    );
  }
}