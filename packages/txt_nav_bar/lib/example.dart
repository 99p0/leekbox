import 'package:flutter/material.dart';

import 'tabIcon_data.dart';
import 'txt_bottom_app_bar.dart';

class TxtBottomNavBarPage extends StatefulWidget {
  @override
  _TxtBottomNavBarPageState createState() => _TxtBottomNavBarPageState();
}

class _TxtBottomNavBarPageState extends State<TxtBottomNavBarPage> {
  final List<TabIconData> tabIconsList = TabIconData.tabIconsList;
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('抖音、小红书'),
        backgroundColor: Color(0xff111111),
        elevation: 0,
      ),
      backgroundColor: Color(0xff111111),
      body: Stack(
        children: [
          content(),
          bottomBar(),
        ],
      ),
    );
  }

  Widget content() {
    return Positioned.fill(
      child: Container(
        alignment: Alignment.center,
        child: Text(pageIndex.toString(),
            style: TextStyle(color: Colors.grey[400], fontSize: 80)),
      ),
    );
  }

  Widget bottomBar() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: TxtBottomNavBar(
        tabIconsList: tabIconsList,
        changeIndex: (index) => onClickBottomBar(index),
        addClick: () {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('点击了中间的按钮')));
        },
      ),
    );
  }

  void onClickBottomBar(int index) {
    if (!mounted) return;
    setState(() => pageIndex = index);
  }
}
