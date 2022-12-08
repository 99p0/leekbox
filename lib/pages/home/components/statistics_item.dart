import 'package:flutter/material.dart';

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
      margin: EdgeInsets.only(bottom: 8, left: 16, right: 16),
      padding: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xffDCE7FA).withOpacity(0.5),
            offset: Offset(0, 2),
            blurRadius: 8,
            spreadRadius: 2,
          ),
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
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  width: 48,
                  height: 48,
                  padding: EdgeInsets.all(16),
                  child: Image.asset(
                    'assets/images/icon_selected.png',
                    height: 16,
                    width: 16,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: content,
            ),
          ),
        ],
      ),
    );
  }
}
