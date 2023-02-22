import 'package:flutter/material.dart';
import 'package:flutter_networking/utils/color/ColorUtils.dart';
import 'package:flutter_networking/utils/dimensize/DimenSizeUtils.dart';

enum TaskMainStatus {
  FREE, //空闲
  WAITING, //等待
  RUNNING, //开始
  STOP, //暂停
  FINISH, //完成
  TERMINATION, //终止
}

extension TaskStatusName on TaskMainStatus{
  String get value => ['空闲', '待开始', '作业中', '暂停', '已完成', '故障'][index];
}

enum MachineOnlineStatus{
  offline,
  online,
}

extension MachineStatusName on MachineOnlineStatus{
  String get value => ['离线','在线'][index];
}

enum TaskType{
  task_deep,
  task_harrow,
  task_tillage,//旋耕
  task_sow,//播种
  task_seeding,//插秧
  task_throwing,//抛秧
  task_harvest,
  task_plant,
  task_trenching,
  task_fertilizer,
  task_topdressing,
  task_ridging,
}

extension TaskTypeName on TaskType{
  String get value => ['深翻', '耙地', '旋耕', '播种', '插秧', '抛秧','收割','植保','开沟','施肥','中耕追肥','起垄'][index];
}

class MachineItemUtil {

  static double imageWidth = DimenSizeUtils.dimenSize_20;

  static List<Widget> list = [
    Image.asset("image/machine/icon_signal_none.png",width: imageWidth,),
    Image.asset("image/machine/icon_signal_one.png",width: imageWidth),
    Image.asset("image/machine/icon_signal_two.png",width: imageWidth),
    Image.asset("image/machine/icon_signal_three.png",width: imageWidth),
    Image.asset("image/machine/icon_signal_four.png",width: imageWidth),
    Image.asset("image/machine/icon_signal_five.png",width: imageWidth),
  ];

  static Color getStatusColor(int status) {
    return status == 1 ? ColorUtils.greenea : ColorUtils.redffea;
  }

  static String getStatus(int status) {
    return status == 1 ? "在线" : "离线";
  }

  static String getTaskStatus(int taskStatus) {
    if(taskStatus>=0&&taskStatus<TaskMainStatus.values.length) {
      return TaskMainStatus.values
          .elementAt(taskStatus)
          .value;
    }
    return TaskMainStatus.FREE.value;
  }

  static Color getTaskStatusColor(int taskStatus) {
    return ColorUtils.green2f;
  }

  static String getTaskTypeName(String combinationTypeName,String implementsName){
    String taskTypeName = "";
    if(combinationTypeName == ""&&implementsName==""){
      return taskTypeName;
    }else {
      return "$combinationTypeName ● $implementsName";
    }
  }

  static String getTaskType(int taskStatus) {
    if(taskStatus>=0&&taskStatus<TaskType.values.length) {
      return TaskType.values
          .elementAt(taskStatus)
          .value;
    }
    return TaskType.task_deep.value;
  }

  static Color getTaskTypeBackgroundColor(int taskStatus){
    if(taskStatus>=0&&taskStatus<TaskMainStatus.values.length) {
      if(taskStatus == TaskMainStatus.WAITING.index){
        return ColorUtils.blackpercent50;
      }
    }
    return Colors.transparent;
  }

  static Color getTaskTypeColor(int taskStatus){
    if(taskStatus>=0&&taskStatus<TaskMainStatus.values.length) {
      if(taskStatus == TaskMainStatus.WAITING.index){
        return ColorUtils.white;
      }
    }
    return Colors.transparent;
  }

  static bool isOnline(int onlineStatus){
    if(onlineStatus>=0&&onlineStatus<MachineOnlineStatus.values.length) {
      if(onlineStatus == MachineOnlineStatus.online.index){
        return true;
      }
    }
    return false;
  }

  static Widget getSignalWidget(int signal){
    int index = 0;
    if(signal>=30){
      index = 5;
    }else if(signal>=25&&signal<30){
      index = 4;
    }else if(signal>=20&&signal<25){
      index = 3;
    }else if(signal>=15&&signal<20){
      index = 2;
    }else if(signal>=0&&signal<15){
      index = 1;
    }else{
      index = 0;
    }
    return list.elementAt(index);
  }

}
