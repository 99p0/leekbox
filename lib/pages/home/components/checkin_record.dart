import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nil/nil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../index.dart';
import 'task_group.dart';

const kSpacing = 20.0;

class CheckinRecord extends ConsumerStatefulWidget {
  const CheckinRecord({super.key});

  @override
  _CheckinRecordState createState() => _CheckinRecordState();
}

class _CheckinRecordState extends ConsumerState<CheckinRecord> {
  Future<bool> getRecentNewsData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 0));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: getRecentNewsData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return nil;
        } else {
          return GestureDetector(
            onTap: () {
              // context.go(RecentNoticePage.routeLocation);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kSpacing),
              child: Column(
                children: [
                  const SizedBox(height: kSpacing),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Calendar',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(PhosphorIcons.calendar),
                        tooltip: "calendar",
                      )
                    ],
                  ),
                  const SizedBox(height: kSpacing),
                  ...taskGroup
                      .map(
                        (e) => buildTaskGroup(
                          title: DateFormat('d MMMM').format(e[0].date),
                          data: e,
                          onPressed: (index, data) {},
                        ),
                      )
                      .toList()
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
