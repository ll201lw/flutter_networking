import 'dart:async';

import 'package:flutter/material.dart';


class ToastUtil{
  static OverlayEntry? overlayEntry;

  static showToast(BuildContext context,String message) async{
    ToastWidget child = ToastWidget(message);
    addOverlay(context,child,message)!;
  }

  static OverlayEntry? addOverlay(BuildContext context,Widget child,String message){
    if(overlayEntry == null) {
      overlayEntry = OverlayEntry(builder: (context) {
        return Positioned(top: 100,
            bottom: 30,
            left: 24,
            right: 24,
            child: child);
      });
      Overlay.of(context!)?.insert(overlayEntry!);
      //与Toast控件时间不一致
      Timer(const Duration(milliseconds: 2000), () {
        overlayEntry?.remove();
        overlayEntry = null;
      });
    }else{
      overlayEntry?.markNeedsBuild();
    }
    return overlayEntry;
  }
}

class ToastWidget extends StatefulWidget{
  ToastWidget(this.message,{super.key});
  late String message;
  late OverlayEntry overlayEntry;
  @override
  State<StatefulWidget> createState() => ToastState(this.message);
}

class ToastState extends State<ToastWidget> with SingleTickerProviderStateMixin{
  ToastState(this.message);
  late AnimationController _controller;
  late Animation _animation;
  late String message;
  late Duration duration = const Duration(milliseconds: 1500);
  late Duration fadeDuration = const Duration(milliseconds: 500);
  late Timer _timer;
  // @override
  // late BuildContext context;

  showToast(String message){
    this.message = message;
  }

  startAnimation(){
    _controller?.forward();
  }

  cancleAnimation(){
    _controller?.reverse();
    _timer?.cancel();
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: fadeDuration
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    super.initState();
    startAnimation();
    _timer = Timer(duration, () {
      cancleAnimation();
    });
  }

  @override
  void deactivate() {
    _timer?.cancel();
    _controller?.stop();
    super.deactivate();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    startAnimation();
    return FadeTransition(
        opacity: _controller,
          child: Center(
              child:Container(
                padding:const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: Text(key: UniqueKey(),message,style: const TextStyle(backgroundColor:Colors.transparent,color: Colors.white,fontSize: 16),),
                ),
              )
          ),
    );
  }

}