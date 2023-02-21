import 'package:flutter/material.dart';


class MachineItem extends StatefulWidget{

  String itemName = "";

   MachineItem({super.key,required this.itemName});

  @override
  State<StatefulWidget> createState() => MachineItemState(itemName: itemName);

}

class MachineItemState extends State<MachineItem>{

  String itemName = "";
  MachineItemState({required this.itemName});

  @override
  Widget build(BuildContext context) {
    throw Container();
  }

}