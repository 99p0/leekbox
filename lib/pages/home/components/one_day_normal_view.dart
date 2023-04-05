import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:leekbox/common/utils/date_util.dart';
import 'package:leekbox/common/widgets/gaps.dart';

import 'lol_words.dart';

/// 当前时间提示 and 美丽的句子
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
              top: MediaQuery.of(context).padding.top,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () async {},
                  child: Text(
                    '${DateUtil.getNowTimeString()}好~',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        // fontWeight: FontWeight.bold,
                        // fontSize: 18,
                        ),
                  ),
                ),
                Gaps.vGap10,
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      words.word,
                      textStyle: Theme.of(context).textTheme.titleSmall,
                      speed: const Duration(milliseconds: 200),
                    ),
                    TypewriterAnimatedText(
                      words.wordEnglish,
                      textStyle: Theme.of(context).textTheme.titleSmall,
                      speed: const Duration(milliseconds: 200),
                    ),
                  ],
                  totalRepeatCount: 10,
                  pause: const Duration(seconds: 2),
                  displayFullTextOnTap: false,
                  stopPauseOnTap: false,
                ),
                Gaps.vGap8,
              ],
            ),
          ),
        );
      },
    );
  }
}
