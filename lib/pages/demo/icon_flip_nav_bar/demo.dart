import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leekbox/pages/activity/activities.page.dart';
import 'package:leekbox/pages/home/index.dart';
import 'package:leekbox/pages/mine/mine.page.dart';
import 'package:leekbox/pages/notice/notice.page.dart';
import 'package:leekbox/pages/tongji/tongji.page.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'navbar.dart';

class BubbleTabBarDemo extends ConsumerStatefulWidget {
  @override
  _BubbleTabBarDemoState createState() => _BubbleTabBarDemoState();
}

class _BubbleTabBarDemoState extends ConsumerState<BubbleTabBarDemo> {
  late List<NavBarItemData> _navBarItems;
  int _selectedNavIndex = 0;

  late List<Widget> _viewsByIndex;

  @override
  void initState() {
    //Declare some buttons for our tab bar
    _navBarItems = [
      NavBarItemData("Home", PhosphorIcons.checkCircle, 110, Color(0xff01b87d)),
      NavBarItemData("Gallery", PhosphorIcons.image, 110, Color(0xff594ccf)),
      NavBarItemData("Camera", PhosphorIcons.camera, 115, Color(0xff09a8d9)),
      NavBarItemData(
          "Likes", PhosphorIcons.facebookLogo, 100, Color(0xffcf4c7a)),
      NavBarItemData(
          "Saved", PhosphorIcons.twitterLogo, 105, Color(0xfff2873f)),
    ];

    //Create the views which will be mapped to the indices for our nav btns
    _viewsByIndex = <Widget>[
      IndexPage(),
      ActivityListPage(),
      NoticePage(),
      TongjiPage(),
      MinePage(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var accentColor = _navBarItems[_selectedNavIndex].selectedColor;

    //Create custom navBar, pass in a list of buttons, and listen for tap event
    var navBar = NavBar(
      items: _navBarItems,
      itemTapped: _handleNavBtnTapped,
      currentIndex: _selectedNavIndex,
    );
    //Display the correct child view for the current index
    var contentView =
        _viewsByIndex[min(_selectedNavIndex, _viewsByIndex.length - 1)];
    //Wrap our custom navbar + contentView with the app Scaffold
    return Scaffold(
      backgroundColor: Color(0xffE6E6E6),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          //Wrap the current page in an AnimatedSwitcher for an easy cross-fade effect
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 350),
            //Pass the current accent color down as a theme, so our overscroll indicator matches the btn color
            child: Theme(
              data: ThemeData(accentColor: accentColor),
              child: contentView,
            ),
          ),
        ),
      ),
      bottomNavigationBar: navBar, //Pass our custom navBar into the scaffold
    );
  }

  void _handleNavBtnTapped(int index) {
    if (mounted) {
      setState(() {
        _selectedNavIndex = index;
      });
    }
  }
}
