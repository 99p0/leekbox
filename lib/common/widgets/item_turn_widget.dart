import 'package:flutter/material.dart';

class ItemTurnWidget extends StatefulWidget {
  String img;
  String title;
  Color bgColor;
  Function onClick;
  double itemHeight;
  double marginVertical;
  double paddingVertical;
  double marginHorizontal;
  double paddingHorizontal;
  String rightTitle;
  bool showArrowRight;

  ItemTurnWidget({
    super.key,
    required this.img,
    required this.title,
    this.bgColor = Colors.transparent,
    required this.onClick,
    this.itemHeight = 60,
    this.marginVertical = 0,
    this.paddingVertical = 0,
    this.marginHorizontal = 0,
    this.paddingHorizontal = 20,
    this.rightTitle = '',
    this.showArrowRight = true,
  });

  @override
  _ItemTurnWidgetState createState() => _ItemTurnWidgetState();
}

class _ItemTurnWidgetState extends State<ItemTurnWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onClick.call();
      },
      child: Container(
        color: widget.bgColor,
        width: MediaQuery.of(context).size.width,
        height: widget.itemHeight,
        margin: EdgeInsets.only(
            left: widget.marginHorizontal,
            right: widget.marginHorizontal,
            top: widget.marginVertical,
            bottom: widget.marginVertical),
        padding: EdgeInsets.only(
            left: widget.paddingHorizontal,
            right: widget.paddingHorizontal,
            top: widget.paddingVertical,
            bottom: widget.paddingVertical),
        child: Stack(
          alignment: AlignmentDirectional.centerStart,
          children: [
            Positioned(
                left: 0,
                child: widget.img != null
                    ? Image.asset(
                        widget.img,
                        width: 20,
                        height: 20,
                      )
                    : Container()),
            Positioned(
                left: widget.img != null ? 40 : 0,
                child: Text(
                  widget.title ?? '',
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                )),
            Positioned(
                right: 20,
                child: Text(
                  widget.rightTitle ?? '',
                  style: TextStyle(
                      color: Color.fromARGB(150, 255, 255, 255).withAlpha(90),
                      fontSize: 14),
                )),
            Positioned(
                right: 0,
                child: widget.showArrowRight
                    ? Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 12,
                        color: Color.fromARGB(150, 255, 255, 255).withAlpha(90),
                      )
                    : Container())
          ],
        ),
      ),
    );
  }
}
