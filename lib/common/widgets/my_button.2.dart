import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyButton2 extends StatelessWidget {
  const MyButton2({
    Key? key,
    this.text = '',
    this.onPressed,
  }) : super(key: key);

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(
      //   right: 10.w,
      //   left: 10.w,
      //   top: 10.h,
      //   bottom: 10.h,
      // ),
      alignment: Alignment.center,
      child: SizedBox(
        width: double.infinity,
        height: 42,
        child: ElevatedButton(
          onPressed: onPressed,
          //定义一下文本样式
          style: ButtonStyle(
            //定义文本的样式 这里设置的颜色是不起作用的
            textStyle: MaterialStateProperty.all(TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            )),
            //
            foregroundColor: MaterialStateProperty.resolveWith(
              (Set<MaterialState> states) {
                //默认状态使用灰色
                return Colors.white;
              },
            ),
            //背景颜色
            backgroundColor:
                MaterialStateProperty.resolveWith((Set<MaterialState> states) {
              return Theme.of(context).primaryColor;
            }),
            //设置水波纹颜色
            // overlayColor: MaterialStateProperty.all(Colors.yellow),
            //设置阴影  不适用于这里的TextButton
            // elevation: MaterialStateProperty.all(0),
            //设置按钮内边距
            padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
            //设置按钮的大小
            // minimumSize: MaterialStateProperty.all(Size(200, 100)),

            //设置边框
            side: MaterialStateProperty.all(
              BorderSide(color: Theme.of(context).primaryColor, width: 0),
            ),
            //外边框装饰 会覆盖 side 配置的样式
            shape: MaterialStateProperty.all(const StadiumBorder()),
          ),
          child: Text(text),
        ),
      ),
    );
  }
}
