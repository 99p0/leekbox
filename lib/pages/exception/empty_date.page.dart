import 'package:flutter/material.dart';
import 'package:leekbox/common/utils/utils.dart';

class EmptyDateWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: SizedBox(),
            flex: 2,
          ),
          SizedBox(
            width: 120.0,
            height: 120.0,
            child: Image.asset(ImageUtils.getImgPath('common/def_avatar')),
          ),
          Text(
            '暂时未获取到数据',
            style: TextStyle(fontSize: 14.0, color: Colors.grey[400]),
          ),
          Expanded(
            child: SizedBox(),
            flex: 3,
          ),
        ],
      ),
    );
  }
}
