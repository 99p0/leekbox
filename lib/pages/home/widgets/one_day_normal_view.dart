import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leekbox/common/utils/date_util.dart';
import 'package:leekbox/common/widgets/gaps.dart';

import 'lol_words.dart';

///当前时间提示 and 美丽的句子
class TimeAndWordView extends StatelessWidget {
  final AnimationController animationController;
  final Animation<Offset> animation;

  const TimeAndWordView(
      {Key? key, required this.animationController, required this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoLWords words = LoLWordsFactory.randomWord();
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return SlideTransition(
          position: animation,
          child: Padding(
            padding: EdgeInsets.only(
                left: 16,
                right: 50,
                top: MediaQuery.of(context).padding.top,
                bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () async {},
                  child: Text(
                    '${DateUtil.getNowTimeString()}好，',
                    style: Theme.of(context).textTheme.headline1?.copyWith(
                        fontWeight: FontWeight.bold, fontSize: 20.sp),
                  ),
                ),
                Gaps.vGap10,
                Text(
                  words.word,
                  style: Theme.of(context).textTheme.headline1?.copyWith(
                      fontSize: 14.sp, fontWeight: FontWeight.normal),
                ),
                Gaps.vGap4,
                Text(
                  words.wordEnglish,
                  style: Theme.of(context).textTheme.headline1?.copyWith(
                      fontSize: 14.sp, fontWeight: FontWeight.normal),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
