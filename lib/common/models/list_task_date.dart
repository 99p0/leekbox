import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListTaskDateData {
  final DateTime date;
  final String label;
  final String jobdesk;

  const ListTaskDateData({
    required this.date,
    required this.label,
    required this.jobdesk,
  });
}

class ListTaskDate extends StatelessWidget {
  const ListTaskDate({
    required this.data,
    required this.onPressed,
    this.dividerColor,
    Key? key,
  }) : super(key: key);

  final ListTaskDateData data;
  final Function() onPressed;
  final Color? dividerColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.all(20 / 2),
        child: Tooltip(
          message: data.label,
          child: Row(
            children: [
              _buildHours(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildDivider(),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitle(),
                    const SizedBox(height: 5),
                    _buildSubtitle(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHours() {
    return Text(
      DateFormat.Hms().format(data.date),
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 3,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        gradient: LinearGradient(
          colors: [
            dividerColor ?? Colors.amber,
            dividerColor?.withOpacity(.6) ?? Colors.amber.withOpacity(.6),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      data.jobdesk,
      maxLines: 1,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w200,
      ),
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildSubtitle() {
    return Text(
      data.label,
      maxLines: 1,
      style: const TextStyle(fontWeight: FontWeight.w600),
      overflow: TextOverflow.ellipsis,
    );
  }
}
