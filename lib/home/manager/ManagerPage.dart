import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_networking/utils/dimensize/DimenSizeUtils.dart';

class ManagerPage extends StatefulWidget {
  const ManagerPage({super.key});

  @override
  State<StatefulWidget> createState() => ManagerState();
}

class ManagerState extends State<ManagerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: UniqueKey(),
      body: const Center(
        child: Text(
          "管理者首页",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Widget totalData(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Positioned(left: DimenSizeUtils.dimenSize_5,child: const Text("服务统计"),)

        ],
      ),
    );
  }
}
