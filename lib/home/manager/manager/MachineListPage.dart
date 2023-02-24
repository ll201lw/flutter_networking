import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_networking/home/entity/manager/MachineEntity.dart';
import 'package:flutter_networking/home/entity/manager/MachineList.dart';
import 'package:flutter_networking/httpapi/HttpApi.dart';
import 'package:flutter_networking/httpapi/HttpHeader.dart';
import 'package:flutter_networking/network/http/DioUtils.dart';
import 'package:flutter_networking/utils/color/ColorUtils.dart';
import 'package:flutter_networking/utils/dimensize/DimenSizeUtils.dart';
import 'package:flutter_networking/utils/image/ImagePathUtil.dart';
import 'package:flutter_networking/utils/machine/MachineItemUtil.dart';
import 'package:flutter_networking/utils/toast/Toast.dart';

class MachineListPage extends StatefulWidget {
  const MachineListPage({super.key});

  @override
  State<StatefulWidget> createState() => MachineListState();
}

class MachineListState extends State<MachineListPage> {
  List<MachineEntity> itemList = [];
  late EasyRefreshController controller;

  @override
  void initState() {
    getMachineList();
    super.initState();
    controller = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: false,
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        title: Center(child: Text(
          "农机列表",
          style: TextStyle(color: Colors.black, fontSize: DimenSizeUtils.sp_15),
        ),),
      ),
      body: EasyRefresh(
        controller: controller,
        header: const TaurusHeader(skyColor: ColorUtils.greenf3),
        onRefresh: (){
          getMachineList();
        },
        child: buildGridView(context, itemList),
      ),
    );
  }

  void getMachineList() {
    DioUtils.instacne.requestNetwork(
        Method.get, HttpApi.getPath(HttpApi.machineList),
        header: HttpHeader.headers(), onSuccess: (data) {
      MachineList machineListEntity =
          MachineList.fromJson(data as List<dynamic>);
      print("machineList:${machineListEntity.machineList?.length}");
      if (mounted) {
        setState(() {
          if (null != machineListEntity) {
            itemList = machineListEntity.machineList!!;
          }
        });
      }
      finishRefresh(controller);
    }, onError: (t, value) {
      Toast.showToast(context, "$t $value");
      finishRefresh(controller);
    });
  }
}

void finishRefresh(EasyRefreshController controller){
  controller?.finishRefresh();
}

Widget buildGridView(BuildContext context, List<MachineEntity> itemList) {
  return Container(
    padding: EdgeInsets.all(DimenSizeUtils.dimenSize_15),
    child: GridView.count(
      padding: EdgeInsets.zero,
      crossAxisCount: 2,
      mainAxisSpacing: DimenSizeUtils.dimenSize_15,
      crossAxisSpacing: DimenSizeUtils.dimenSize_15,
      children: _buildGridViewChild(context, itemList),
    ),
  );
}

List<Widget> _buildGridViewChild(
    BuildContext context, List<MachineEntity> itemList) {
  List<Widget> list = [];
  for (int i = 0; i < itemList.length; i++) {
    MachineEntity item = itemList.elementAt(i);
    int taskStatus = item.taskStatus ??= 0;
    int onlineStatus = item.terminalStatus ??= 0;
    int signal = item.signal ??= -1;
    String image = item.image==null||""==item.image?"":ImagePathUtil.getImagePath(item.image!!);
    String status = MachineItemUtil.getStatus(onlineStatus);
    String taskType = item.taskFeild ??=
        "" + "田块" + MachineItemUtil.getTaskType(item.taskType ??= 0);
    Color color = MachineItemUtil.getStatusColor(onlineStatus);
    String taskStatusString = MachineItemUtil.getTaskStatus(taskStatus);
    Color taskColor = MachineItemUtil.getTaskStatusColor(taskStatus);
    String machineName = item.machineryName!!;
    Color taskTypeBackgroundColor =
        MachineItemUtil.getTaskTypeBackgroundColor(taskStatus);
    Color taskTypeColor = MachineItemUtil.getTaskTypeColor(taskStatus);
    String taskTypeName = MachineItemUtil.getTaskTypeName(
        item.combinationTypeName ??= "", item.implementsName ??= "");
    Widget widget = _buildGridViewItem(context, image, status, color, taskType, machineName, taskStatus, onlineStatus,
        taskTypeBackgroundColor, taskTypeColor, taskStatusString, taskColor, taskTypeName, signal);
    list.add(widget);
  }
  return list;
}

Widget _buildGridViewItem(BuildContext context, String url, String status, Color color, String taskType, String machineName, int taskStatus, int onlineStatus,
    Color taskTypeBackgroundColor, Color taskTypeColor, String taskStatusString, Color taskColor, String taskTypeName, int singal) {
  return ClipRRect(
    borderRadius: BorderRadius.all(Radius.circular(DimenSizeUtils.dimenSize_8)),
    child: Container(
      padding: EdgeInsets.zero,
      color: Colors.white,
      height: DimenSizeUtils.dimenSize_175,
      child: Column(
        children: [
          _buildMachinePic(context, url, status, taskStatus, onlineStatus,
              taskTypeBackgroundColor, taskTypeColor, color, taskType, singal),
          _buildMachineName(context, machineName, taskStatusString, taskColor),
          _buildMachineTaskType(context, taskTypeName)
        ],
      ),
    ),
  );
}
Widget _buildImage(String image){
  if("" == image || '' == image){
    return Image.asset("image/ic_launcher.png",fit: BoxFit.fill,width: double.infinity,height: double.infinity,);
  }
  return Image.network(image, fit: BoxFit.fill,width: double.infinity, height: DimenSizeUtils.dimenSize_110,);
}

Widget _buildMachinePic(BuildContext context, String url, String status, int taskStatus, int onlineStatus,
    Color taskTypeBackgroundColor, Color taskTypeColor, Color color, String taskType, int signal) {
  return Container(
    width: double.infinity,
    height: DimenSizeUtils.dimenSize_110,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(DimenSizeUtils.dimenSize_8),
            topRight: Radius.circular(DimenSizeUtils.dimenSize_8))),
    child: Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(DimenSizeUtils.dimenSize_8),
              topRight: Radius.circular(DimenSizeUtils.dimenSize_8)),
          child: _buildImage(url),
        ),
        Positioned(
            right: 0,
            top: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(DimenSizeUtils.dimenSize_8),
                  bottomLeft: Radius.circular(DimenSizeUtils.dimenSize_8)),
              child: Container(
                width: DimenSizeUtils.dimenSize_44,
                height: DimenSizeUtils.dimenSize_27,
                color: color,
                child: Center(
                  child: _buildTaskStatusWidget(
                      context, taskStatus, onlineStatus, status, signal),
                ),
              ),
            )),
        Container(
            margin: EdgeInsets.only(top: DimenSizeUtils.dimenSize_83),
            width: double.infinity,
            height: DimenSizeUtils.dimenSize_27,
            color: taskTypeBackgroundColor,
            child: Stack(
              children: [
                Positioned(
                    left: DimenSizeUtils.dimenSize_10,
                    top: DimenSizeUtils.dimenSize_5,
                    child: Text(
                      taskType,
                      style: TextStyle(
                          color: taskTypeColor, fontSize: DimenSizeUtils.sp_13),
                    )),
              ],
            ))
      ],
    ),
  );
}

Widget _buildTaskStatusWidget(BuildContext context, int taskStatus, int status,
    String statusString, int signal) {
  if (MachineItemUtil.isOnline(status)) {
    return MachineItemUtil.getSignalWidget(signal);
  } else {
    return _buildTaskStatusText(statusString);
  }
}

Widget _buildTaskStatusText(String statusString) {
  return Text(
    statusString,
    style: TextStyle(color: ColorUtils.redf64c, fontSize: DimenSizeUtils.sp_12),
  );
}

Widget _buildMachineName(BuildContext context, String machineName,
    String taskStatus, Color taskColor) {
  return Container(
    margin: EdgeInsets.zero,
    height: DimenSizeUtils.dimenSize_30,
    child: Stack(
      children: [
        Positioned(
            left: DimenSizeUtils.dimenSize_10,
            top: DimenSizeUtils.dimenSize_10,
            child: Text(
              machineName,
              style: TextStyle(
                  color: Colors.black, fontSize: DimenSizeUtils.sp_13),
            )),
        Positioned(
            right: DimenSizeUtils.dimenSize_10,
            top: DimenSizeUtils.dimenSize_11,
            child: Text(
              taskStatus,
              style:
                  TextStyle(color: taskColor, fontSize: DimenSizeUtils.sp_11),
            ))
      ],
    ),
  );
}

Widget _buildMachineTaskType(BuildContext context, String taskTypeName) {
  return Container(
    margin: EdgeInsets.zero,
    height: DimenSizeUtils.dimenSize_23,
    child: Stack(
      children: [
        Positioned(
            left: DimenSizeUtils.dimenSize_10,
            top: DimenSizeUtils.dimenSize_1,
            child: Text(
              taskTypeName,
              style: TextStyle(
                  color: ColorUtils.grey66, fontSize: DimenSizeUtils.sp_11),
            )),
      ],
    ),
  );
}
