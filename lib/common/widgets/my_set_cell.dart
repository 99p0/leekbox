import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const double _imgWH = 25.0; //左侧图片宽高
const double _titleSpace = 100.0; //左侧title默认宽
const double _cellHeight = 56.0; //输入、选择样式一行的高度
const double _leftEdge = 15.0; //内部Widget 左边距 15
const double _rightEdge = 10.0; //内部Widget 左边距 10
const double _lineLeftEdge = 45.0; //线 左间距 默认 15
const double _lineRightEdge = 10; //线 右间距 默认  0
const double _lineHeight = 0.1; //底部线高

typedef _ClickCallBack = void Function();

class MySetCell extends StatefulWidget {
  //默认靠右

  const MySetCell({
    Key? key,
    this.title = '',
    this.leftImgPath,
    this.leftWidget,
    this.text = '',
    this.hiddenArrow = false,
    this.rightWidget,
    this.clickCallBack,
    this.titleWidth = _titleSpace,
    this.titleStyle,
    this.textStyle,
    this.hiddenLine = false,
    this.lineLeftEdge = _lineLeftEdge,
    this.lineRightEdge = _lineRightEdge,
    this.bgColor,
    this.cellHeight = _cellHeight,
    this.leftImgWH = _imgWH,
    this.textAlign = TextAlign.right,
  }) : super(key: key);
  final String title;
  final String? leftImgPath; //左侧图片路径 ，默认隐藏 ,设置leftImgPath则 leftWidget失效
  final Widget? leftWidget; //左侧widget ，默认隐藏
  final String text;
  final Widget? rightWidget; //右侧widget ，默认隐藏
  final bool hiddenArrow; //隐藏箭头，默认不隐藏
  final _ClickCallBack? clickCallBack;
  final double titleWidth; //标题宽度
  final TextStyle? titleStyle;
  final TextStyle? textStyle;
  final bool hiddenLine; //隐藏底部横线
  final double lineLeftEdge; //底部横线左侧距离 默认_leftEdge
  final double lineRightEdge; //底部横线右侧距离 默认0
  final Color? bgColor; //背景颜色，默认白色
  final double cellHeight; //底部横线右侧距离 默认_cellHeight
  final double leftImgWH; //左侧图片宽高，默认_imgWH
  final TextAlign textAlign;

  @override
  _MySetCellState createState() => _MySetCellState();
}

class _MySetCellState extends State<MySetCell> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.bgColor,
      child: InkWell(
        radius: 0.0,
        child: Container(
          constraints: BoxConstraints(
            minWidth: double.infinity,
            minHeight: widget.cellHeight,
          ),
          padding: const EdgeInsets.fromLTRB(_leftEdge, 0, _rightEdge, 0),
          decoration: UnderlineTabIndicator(
            borderSide: BorderSide(
              width: _lineHeight,
              color: widget.hiddenLine == true
                  ? Colors.transparent
                  : const Color(0xFFE6E6E6),
            ),
            insets: EdgeInsets.fromLTRB(
                widget.lineLeftEdge, 0, widget.lineRightEdge, 0),
          ),
          child: Row(
            children: <Widget>[
              if (widget.leftImgPath != null)
                Image.asset(
                  widget.leftImgPath!,
                  width: widget.leftImgWH,
                  height: widget.leftImgWH,
                )
              else
                widget.leftWidget != null ? widget.leftWidget! : Container(),
              SizedBox(
                  width:
                      (widget.leftImgPath != null || widget.leftWidget != null)
                          ? 12
                          : 0),
              Offstage(
                offstage: widget.title.isEmpty,
                child: SizedBox(
                  width: widget.titleWidth,
                  child: Text(
                    widget.title,
                    style: widget.titleStyle ??
                        Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                            ),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  widget.text,
                  style: widget.textStyle ??
                      Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 13.sp,
                          ),
                  textAlign: widget.textAlign,
                ),
              ),
              if (widget.rightWidget != null)
                widget.rightWidget!
              else
                Container(),
              Offstage(
                offstage: widget.hiddenArrow,
                child: const Icon(Icons.arrow_forward_ios,
                    size: 18, color: Color(0xFFC8C8C8)),
              ),
            ],
          ),
        ),
        onTap: () async {
          if (widget.clickCallBack != null) {
            widget.clickCallBack!();
          }
        },
      ),
    );
  }
}
