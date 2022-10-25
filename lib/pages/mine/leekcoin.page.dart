import 'package:flutter/material.dart';
import 'package:leekbox_sdk/log.dart';

///
class LeekCoinPage extends StatefulWidget {
  @override
  _LeekCoinPageState createState() => _LeekCoinPageState();
}

class _LeekCoinPageState extends State<LeekCoinPage>
    {


  @override
  Widget build(BuildContext context) {
    // super.build(context);
    Log.debug('LeekCoinPage build');
    return Scaffold(
      body: Column(
        children: <Widget>[
          ClipPath(
            clipper: MyClipper(),
            child: Container(
              padding: const EdgeInsets.all(8),
              height: 350,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Color(0xFF3383CD), Color(0xFF11249F)]),
              ),
              child: Column(
                children: [],
              ),
            ),
          ),
          Text('韭菜盒子'),
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
