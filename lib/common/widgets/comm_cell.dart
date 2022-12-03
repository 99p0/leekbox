import 'package:flutter/material.dart';

class DiscoverCell extends StatefulWidget {
  final String? title;
  final String? imageName;
  final String? subTitle;
  final String? subImageName;

  DiscoverCell(
      {super.key,
      required this.title,
      required this.imageName,
      this.subTitle,
      this.subImageName})
      : assert(title != null, "title 不能为空"),
        assert(imageName != null, "imageName 不能为空");

  @override
  _DiscoverCellState createState() => _DiscoverCellState();
}

class _DiscoverCellState extends State<DiscoverCell> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          print('$widget.title');
        },
        onTapCancel: () {},
        onTapDown: (TapDownDetails details) {},
        child: Container(
          height: 55,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // left
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    //image
                    Image(
                      image: AssetImage(widget.imageName!),
                      width: 20,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    //title
                    Text(widget.title!),
                  ],
                ),
              ),
              // right
              Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      // subtitle
                      Text(widget.subTitle ?? ""),
                      // subimage
                      widget.subImageName != null
                          ? Image(
                              image: AssetImage(widget.subImageName!),
                              width: 12,
                            )
                          : Container(),
                      //箭头
                      Image(
                        image: AssetImage('images/icon_right.png'),
                        width: 15,
                      ),
                    ],
                  )),
            ],
          ),
        ));
  }
}
