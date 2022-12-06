import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leekbox/common/widgets/gaps.dart';
import 'package:leekbox/common/widgets/my_set_cell.dart';

class MyEndDrawer extends StatelessWidget {
  const MyEndDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: double.infinity, // MediaQuery.of(context).size.width * 0.85,
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
                      child: Image.network(
                        "https://avatar.csdnimg.cn/2/2/B/2_u013600907.jpg",
                        width: 80,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "全局UI设置",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
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
                    title: 'UI',
                    leftImgPath: 'assets/images/mine/ic_moneybags.png',
                    clickCallBack: () => {},
                  ),
                  Gaps.vGap4,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
