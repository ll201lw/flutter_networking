import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<StatefulWidget> createState() => TaskState();
}

class TaskState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: UniqueKey(),
        body: const Center(
          child: Text(
            "作业界面",
            style: TextStyle(color: Colors.black),
          ),
        ));
  }
}
