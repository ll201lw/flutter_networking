import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_networking/home/manager/ManagerPage.dart';
import 'package:flutter_networking/utils/color/ColorUtils.dart';
import 'package:provider/provider.dart';

import '../mine/MinePage.dart';
import '../task/TaskPage.dart';
import '../utils/dimensize/DimenSizeUtils.dart';
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
    super.initState();
    initPageList();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
    pageController?.dispose();
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
  // TODO: implement restorationId
  String? get restorationId => "home";

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(provider, "BottomNavigationBarCurrentIndex");
  }




}