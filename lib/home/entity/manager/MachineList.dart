
import 'package:flutter_networking/home/entity/manager/MachineEntity.dart';


class MachineList{
  List<MachineEntity>? machineList;


  MachineList({this.machineList});

  factory MachineList.fromJson(List<dynamic> list){
    List<MachineEntity> machineList = <MachineEntity>[];
    machineList = list.map((i)=>MachineEntity.fromJson(i)).toList();
    return MachineList(machineList: machineList);
  }

}