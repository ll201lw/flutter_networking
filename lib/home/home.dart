import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_networking/home/manager/ManagerPage.dart';
import 'package:flutter_networking/utils/color/ColorUtils.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

import '../constant/Constant.dart';
import '../httpapi/HttpApi.dart';
import '../httpapi/HttpHeader.dart';
import '../mine/MinePage.dart';
import '../network/http/DioUtils.dart';
import '../task/TaskPage.dart';
import '../utils/dimensize/DimenSizeUtils.dart';
import '../utils/toast/Toast.dart';
import 'HomeProvider.dart';

class HomePage extends StatefulWidget{

  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => HomeState();

}

class HomeState extends State<HomePage> with RestorationMixin{

  static double imageSize = DimenSizeUtils.dimenSize_20;

  late List<Widget> _pageList;
  final List<String> bottomBarItemName = ["首页","作业","我的"];
  final PageController pageController = PageController();
  HomeProvider provider = HomeProvider();

  List<BottomNavigationBarItem>? _list;
  List<BottomNavigationBarItem>? _darkList;
  int currentIndex = 0;

  IOWebSocketChannel? channel;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>(
      create:(_)=>provider,
      child: Scaffold(
        bottomNavigationBar: Consumer<HomeProvider>(
            builder:(_,provider,__){
              return BottomNavigationBar(
                backgroundColor: Colors.white,
                items: _buildList(),
                type: BottomNavigationBarType.fixed,
                currentIndex: provider.value,
                elevation: 5.0,
                iconSize: 21.0,
                selectedFontSize: DimenSizeUtils.sp_10,
                unselectedFontSize: DimenSizeUtils.sp_10,
                selectedItemColor: ColorUtils.green2f,
                unselectedItemColor: ColorUtils.black,
                onTap: (index) => pageController.jumpToPage(index),
              );
            }
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          onPageChanged: (int index)=>provider.value = index,
          children: _pageList,
        ),
      ),
    );
  }

  @override
  void initState() {
    initWebsocekt();
    super.initState();
    initPageList();
    getMachineList();
  }

  @override
  void didUpdateWidget(covariant HomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    pageController?.dispose();
    channel?.sink.close(status.goingAway);
    super.dispose();
  }


  initPageList(){
    _pageList = [
      const ManagerPage(),
      const TaskPage(),
      const MinePage()
    ];
  }

  List<BottomNavigationBarItem> _buildList(){
    if(_list == null){
      var tabImages = [[
        Image.asset("image/home/icon_home_normal.png",width: imageSize,),
        Image.asset("image/home/icon_home_select.png",width: imageSize,)
      ],[
        Image.asset("image/home/icon_task_normal.png",width: imageSize,),
        Image.asset("image/home/icon_task_select.png",width: imageSize,),
      ],[
        Image.asset("image/home/icon_mine_normal.png",width: imageSize,),
        Image.asset("image/home/icon_mine_select.png",width: imageSize,),
      ]];
      _list = List.generate(tabImages.length, (index){
        return BottomNavigationBarItem(
          icon: tabImages[index][0],
          activeIcon: tabImages[index][1],
          label: bottomBarItemName[index],
          tooltip: bottomBarItemName[index],
        );
      });
    }
    return _list!;

  }

  @override
  String? get restorationId => "home";

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(provider, "BottomNavigationBarCurrentIndex");
  }

  void getMachineList(){
    DioUtils.instacne.requestNetwork(Method.get, HttpApi.getPath(HttpApi.machineList),
        header: HttpHeader.headers(), onSuccess: (data) {
          print("machineList:$data");
          // var entity = PicCodeEntity.fromJson(data as Map<String, dynamic>);
          // setState(() {
          //
          // });
        }, onError: (t, value) {
          Toast.showToast(context, "$t $value");
        });
  }


  void initWebsocekt(){
    String deviceCode = "J101M102";
    String websocketBaseUrl = Constant.websocketBaseUrl+Constant.websocketPath+Constant.getWebSocketTokenString(Constant.tokenValue);
    channel = IOWebSocketChannel.connect(websocketBaseUrl);
    channel?.stream.listen((message) {
      print("websocket message:$message");
    });
    channel?.sink.add("{\"code\":10001,\"deviceId\":\"$deviceCode\"}");
  }


}