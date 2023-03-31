import 'package:flutter/material.dart';

class StatisticsHeaderContent extends StatelessWidget {
  const StatisticsHeaderContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Row(
        children: [
          Expanded(child: _item('assets/images/common/xdd.png', '新订单(单)', '80')),
          Expanded(child: _item('assets/images/common/dps.png', '待配送(单)', '80')),
          Expanded(
              child: _item('assets/images/common/jrjye.png', '今日交易额(元)', '8000.00')),
        ],
      ),
    );
  }

  Widget _item(String image, String title, String content) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          image,
          width: 40,
          height: 40,
        ),
        const SizedBox(height: 6),
        Text(
          title,
          style: const TextStyle(color: Color(0xFF999999), fontSize: 12),
        ),
        const SizedBox(height: 6),
        Text(
          content,
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
