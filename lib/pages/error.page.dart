import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: Lottie.asset(
                'assets/json/error2.json',
                width: size.width / 1.3,
                height: 160,
                fit: BoxFit.fill,
                alignment: Alignment.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '虽然什么也没有,要不刷新看看',
                  style: TextStyle(fontSize: 15, color: Colors.grey.shade400),
                ),
                // GestureDetector(
                //   onTap: () => this.helpAction(),
                //   child: Icon(
                //     IconFont.icon_info,
                //     size: 18,
                //     color: Colors.grey,
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
