import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leekbox_infra/log/log.dart';

///
class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  //滑动控制器
  late ScrollController _controller;

  @override
  void initState() {
    //初始化控制器
    _controller = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    //销毁控制器
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Log.debug('MinePage build');
    return Material(
      child: CustomScrollView(
        controller: _controller,
        slivers: <Widget>[
          // AppBar，包含一个导航栏
          SliverAppBar(
            // 设置为true时，向下滑动时，即使当前CustomScrollView不在顶部，SliverAppBar也会跟着一起向下出现
            floating: true,
            //设置为true时，当SliverAppBar内容滑出屏幕时，将始终渲染一个固定在顶部的收起状态
            pinned: true,
            // 设置为true时，当手指放开时，SliverAppBar会根据当前的位置进行调整，始终保持展开或收起的状态，此效果在floating=true时生效
            snap: false,
            expandedHeight: 250.0,
            leading: IconButton(
              icon: Icon(Icons.person_outline),
              onPressed: () {},
            ),
            actions: <Widget>[
              TextButton(
                child: Text('返回顶部'),
                onPressed: () {
                  _controller.animateTo(.0,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.ease);
                },
              ),

              // _buildHeader(),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('LEEKBOX'),
              collapseMode: CollapseMode.pin,
              background: Image.network(
                "https://ssyerv1.oss-cn-hangzhou.aliyuncs.com/picture/389e31d03d36465d8acd9939784df6f0.jpg!sswm",
                fit: BoxFit.cover,
              ),
            ),
          ),
          //List
          SliverFixedExtentList(
            itemExtent: 60.0,
            delegate: new SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              //创建列表项
              return new Container(
                alignment: Alignment.center,
                color: Colors.lightBlue[100 * (index % 9)],
                child: new Text('list item $index'),
              );
            }, childCount: 50 //50个列表项
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 76.w,
      height: 76.w,
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
          size: 24.w,
          color: Theme.of(context).primaryTextTheme.headline6?.color,
        ),
        SizedBox(width: 20.w),
        Icon(
          Icons.chevron_right,
          size: 24.w,
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
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 40)),
      ),
      onPressed: () {},
      child: Column(
        children: [
          Text(number, style: TextStyle(fontSize: 22.sp, color: foreColor)),
          Text(text, style: TextStyle(color: foreColor)),
        ],
      ),
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
