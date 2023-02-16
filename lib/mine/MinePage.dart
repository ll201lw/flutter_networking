import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<StatefulWidget> createState() => MineState();
}

class MineState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: UniqueKey(),
        body: const Center(
          child: Text(
            "我的界面",
            style: TextStyle(color: Colors.black),
          ),
        ));
  }
}
