import 'package:flutter/material.dart';
import 'package:leekbox/common/utils/utils.dart';

class StatisticsItem extends StatelessWidget {
  final String title;
  final Widget content;
  final VoidCallback onTap;

  const StatisticsItem({
    Key? key,
    required this.title,
    required this.content,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        // color: Colors.blue,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [],
      ),
      height: 180,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: onTap,
            behavior: HitTestBehavior.translucent,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w100),
                  ),
                ),
                Container(
                  width: 38,
                  height: 38,
                  padding: const EdgeInsets.all(13),
                  child: Image.asset(
                    ImageUtils.getImgPath('common/icon_selected'),
                    height: 16,
                    width: 16,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: content,
            ),
          ),
        ],
      ),
    );
  }
}
