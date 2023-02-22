import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_networking/utils/color/ColorUtils.dart';
import 'package:flutter_networking/utils/dimensize/DimenSizeUtils.dart';
import 'package:flutter_networking/utils/toast/ToastUtil.dart';

import '../../constant/Constant.dart';
import 'manager/MachineListPage.dart';

class ManagerPage extends StatefulWidget {
  const ManagerPage({super.key});

  @override
  State<StatefulWidget> createState() => ManagerState();
}

class ManagerState extends State<ManagerPage> {
  final messageIcon = Image.asset("image/home/home/icon_main_message.png");
  static final double imageWidth = DimenSizeUtils.dimenSize_41;
  static final double imageHeight = DimenSizeUtils.dimenSize_40;
  List<Widget> itemList = [
    Image.asset(
      "image/home/home/icon_machine_archives.png",
      width: imageWidth,
    ),
    Image.asset(
      "image/home/home/icon_work_report.png",
      width: imageWidth,
    ),
    Image.asset(
      "image/home/home/icon_drivers_manager.png",
      width: imageWidth,
    ),
    Image.asset(
      "image/home/home/icon_machine_tools.png",
      width: imageWidth,
    ),
    Image.asset(
      "image/home/home/icon_post_manager.png",
      width: imageWidth,
    ),
    Image.asset(
      "image/home/home/icon_field_distribution.png",
      width: imageWidth,
    ),
    Image.asset(
      "image/home/home/icon_electronic_fence.png",
      width: imageWidth,
    ),
    Image.asset(
      "image/home/home/icon_maintenance.png",
      width: imageWidth,
    ),
  ];

  List<String> itemName = [
    "农机档案",
    "工作日报",
    "机手管理",
    "机具管理",
    "岗位管理",
    "农场管理",
    "电子围栏",
    "维修服务",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: UniqueKey(),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
            color: ColorUtils.green2f,
            width: double.infinity,
            height: DimenSizeUtils.dimenSize_87,
            child: topWidget(context),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(DimenSizeUtils.dimenSize_15,
                  DimenSizeUtils.dimenSize_15, DimenSizeUtils.dimenSize_15, 0),
              width: double.infinity,
              height: DimenSizeUtils.dimenSize_140,
              decoration: BoxDecoration(
                  color: ColorUtils.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(DimenSizeUtils.dimenSize_8),
                      topRight: Radius.circular(DimenSizeUtils.dimenSize_8),
                      bottomLeft: Radius.circular(DimenSizeUtils.dimenSize_8),
                      bottomRight:
                          Radius.circular(DimenSizeUtils.dimenSize_8))),
              child: Container(
                width: double.infinity,
                height: DimenSizeUtils.dimenSize_49,
                margin: EdgeInsets.fromLTRB(
                    DimenSizeUtils.dimenSize_1,
                    DimenSizeUtils.dimenSize_1,
                    DimenSizeUtils.dimenSize_1,
                    DimenSizeUtils.dimenSize_90),
                decoration: BoxDecoration(
                    color: ColorUtils.green2f,
                    gradient: const LinearGradient(
                        colors: [ColorUtils.greenbf, ColorUtils.greene6]),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(DimenSizeUtils.dimenSize_7),
                        topRight: Radius.circular(DimenSizeUtils.dimenSize_7))),
                child: Stack(
                  children: [
                    Positioned(
                      left: DimenSizeUtils.dimenSize_14,
                      top: DimenSizeUtils.dimenSize_14,
                      height: DimenSizeUtils.dimenSize_49,
                      child: Text(
                        "服务统计",
                        style: TextStyle(
                          fontSize: DimenSizeUtils.sp_15,
                          color: ColorUtils.green18,
                        ),
                      ),
                    ),
                    Positioned(
                      right: DimenSizeUtils.dimenSize_14,
                      top: DimenSizeUtils.dimenSize_14,
                      height: DimenSizeUtils.dimenSize_49,
                      child: Text(
                        "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}",
                        style: TextStyle(
                          fontSize: DimenSizeUtils.sp_15,
                          color: ColorUtils.grey66,
                        ),
                      ),
                    )
                  ],
                ),
              )),

          //gridview
          Container(
            margin: EdgeInsets.fromLTRB(DimenSizeUtils.dimenSize_15,
                DimenSizeUtils.dimenSize_16, DimenSizeUtils.dimenSize_15, 0),
            width: double.infinity,
            height: DimenSizeUtils.dimenSize_222,
            decoration: BoxDecoration(
                color: ColorUtils.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(DimenSizeUtils.dimenSize_8),
                    topRight: Radius.circular(DimenSizeUtils.dimenSize_8),
                    bottomLeft: Radius.circular(DimenSizeUtils.dimenSize_8),
                    bottomRight: Radius.circular(DimenSizeUtils.dimenSize_8))),
            child: Container(
              padding: EdgeInsets.only(top: DimenSizeUtils.dimenSize_25),
              child: GridView.count(
                padding: EdgeInsets.zero,
                crossAxisCount: 4,
                mainAxisSpacing: DimenSizeUtils.dimenSize_12,
                crossAxisSpacing: DimenSizeUtils.dimenSize_13,
                children: _buildGridViewChild(context, itemList, itemName),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildGridViewChild(
      BuildContext context, List<Widget> itemList, List<String> itemName) {
    List<Widget> list = [];
    for (int i = 0; i < itemList.length; i++) {
      Widget widget =
          _buildChild(context, itemList.elementAt(i), itemName.elementAt(i),i);
      list.add(widget);
    }
    return list;
  }

  Widget _buildChild(BuildContext context, Widget widget, String name,int position) {
    return GestureDetector(
      onTap: (){
        onGridViewItemTap(context, position);
      },
      child: SizedBox(
        width: DimenSizeUtils.dimenSize_52,
        height: DimenSizeUtils.dimenSize_88,
        child: Column(
          children: [
            widget,
            SizedBox(
              height: DimenSizeUtils.dimenSize_17,
            ),
            Center(
              widthFactor: 1,
              heightFactor: 1,
              child: Text(
                name,
                style: TextStyle(
                    color: ColorUtils.black11,
                    fontSize: DimenSizeUtils.dimenSize_11),
              ),
            )
          ],
        ),
      ),
    );
  }

  void onGridViewItemTap(BuildContext context,int position){
    if(position == 0){
      //农机档案
      // CupertinoPageRoute
      Navigator.push(context, CupertinoPageRoute(builder: (_) => const MachineListPage()),);
    }else if(position == 1){
      //工作日报
    }else if(position == 2){
      //机手管理
    }else if(position == 3){
      //机具管理
    }else if(position == 4){
      //岗位管理
    }else if(position == 5){
      //农场管理
    }else if(position == 6){
      //电子围栏
    }else if(position == 7){
      //维修服务
    }
  }

  //顶部沉浸式状态栏及消息icon
  Widget topWidget(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: DimenSizeUtils.dimenSize_20,
          top: DimenSizeUtils.dimenSize_55,
          width: DimenSizeUtils.dimenSize_20,
          child: messageIcon,
        ),
      ],
    );
  }
}
