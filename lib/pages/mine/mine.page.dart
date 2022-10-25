import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leekbox_sdk/log.dart';

///
class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {

  @override
  Widget build(BuildContext context) {
    // super.build(context);
    Log.debug('MinePage build');
    return Scaffold(
      body: Column(
        children: <Widget>[
          ClipPath(
            clipper: MyClipper(),
            child: Container(
              padding: EdgeInsets.only(left: 25.w, right: 25.w),
              height: 450.h,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Color(0xFF3383CD), Color(0xFF11249F)],
                ),
              ),
              child: _buildHeader(),
            ),
          ),
          _buildCard(),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 120.w,
      height: 120.w,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        image: const DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
              'https://pic2.zhimg.com/v2-639b49f2f6578eabddc458b84eb3c6a1.jpg'),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: <Widget>[
        //
        _buildAvatar(),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 30.w, right: 30.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // 用户名
                Text('LEEKBOX '),
                SizedBox(height: 10.w),
                Text('ID: 110111  '),
                // 等级、经验s
                // Container(
                //   child: Column(children: [
                //     Row(
                //       children: [
                //         Text('LV3'),
                //         Text('9372/27000'),
                //       ],
                //     ),
                //     const LinearProgressIndicator(
                //       value: 0.3,
                //       valueColor: AlwaysStoppedAnimation(Colors.blue),
                //     ),
                //   ]),
                // ),
                // 个性签名
                Text('地区： 北京市'),
              ],
            ),
          ),
        ),
        // 二维码和右箭头
        Icon(
          Icons.qr_code,
          size: 30.w,
          color: Theme.of(context).primaryTextTheme.headline6?.color,
        ),
        SizedBox(width: 20.w),
        Icon(
          Icons.chevron_right,
          size: 30.w,
          color: Theme.of(context).primaryTextTheme.headline6?.color,
        ),
      ],
    );
  }

  Widget _buildCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 0, 5, 10),
      child: Card(
        child: Container(
          margin: const EdgeInsets.fromLTRB(5, 10, 5, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNumberTextWidget('62', '动态'),
              _buildNumberTextWidget('18', '关注'),
              _buildNumberTextWidget('89', '粉丝'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNumberTextWidget(String number, String text) {
    var foreColor = Theme.of(context).primaryColor;
    return TextButton(
      child: Column(children: [
        Text(number, style: TextStyle(fontSize: 30, color: foreColor)),
        Text(text, style: TextStyle(color: foreColor)),
      ]),
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 40)),
      ),
      onPressed: () {},
    );
  }
// @override
// bool get wantKeepAlive => true;
}

///
class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    throw false;
  }
}
