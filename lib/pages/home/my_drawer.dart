import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leekbox/common/widgets/gaps.dart';
import 'package:leekbox/common/widgets/my_set_cell.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: double.infinity,
      child: MediaQuery.removePadding(
        context: context,
        //移除抽屉菜单顶部默认留白
        removeTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 38.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ClipOval(
                      child: Image.asset(
                        "assets/images/def_avatar.png",
                        width: 80,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Wendux",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Divider(), //一条线
                  Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: GestureDetector(
                      child: const Icon(
                        Icons.close,
                        color: Colors.grey,
                        size: 26,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Gaps.vLine,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Gaps.vGap12,
                  MySetCell(
                    title: '荷包',
                    leftImgPath: 'assets/images/mine/ic_moneybags.png',
                    clickCallBack: () => {},
                  ),
                  Gaps.vGap4,
                  MySetCell(
                    title: '会员',
                    leftImgPath: 'assets/images/mine/ic_vip_gold.png',
                    clickCallBack: () => {},
                  ),
                  MySetCell(
                    title: '卡包',
                    leftImgPath: 'assets/images/mine/ic_cards_wallet.png',
                    clickCallBack: () => {},
                  ),
                  Gaps.vGap4,
                  MySetCell(
                    title: '设置',
                    leftImgPath: 'assets/images/mine/ic_setting.png',
                    clickCallBack: () => {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
