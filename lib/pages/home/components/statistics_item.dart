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
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.only(bottom: 16),
      decoration: const BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          // BoxShadow(
          //   color: const Color(0xffDCE7FA).withOpacity(0.5),
          //   offset: Offset(0, 2),
          //   blurRadius: 8,
          //   spreadRadius: 2,
          // ),
        ],
      ),
      height: 160,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: onTap,
            behavior: HitTestBehavior.translucent,
            child: Row(
              children: [
                const SizedBox(width: 16),
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
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: content,
            ),
          ),
        ],
      ),
    );
  }
}
