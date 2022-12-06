class DateUtil {
  static bool isToday(int millisecondsSinceEpoch) {
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    DateTime now = DateTime.now();
    return DateTime(dateTime.year, dateTime.month, dateTime.day) ==
        DateTime(now.year, now.month, now.day);
  }

  static String getDayString(int millisecondsSinceEpoch) {
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    return '${dateTime.year}-${dateTime.month}-${dateTime.day}';
  }

  static String formDateTime(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month}-${dateTime.day}';
  }

  static int millisecondsUntilTomorrow() {
    DateTime now = DateTime.now();
    DateTime tomorrow = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);
    return tomorrow.millisecondsSinceEpoch - now.millisecondsSinceEpoch;
  }

  static String getWeekendString(int weekday) {
    String str = '';
    switch (weekday) {
      case 1:
        str = '一';
        break;
      case 2:
        str = '二';
        break;
      case 3:
        str = '三';
        break;
      case 4:
        str = '四';
        break;
      case 5:
        str = '五';
        break;
      case 6:
        str = '六';
        break;
      case 7:
        str = '日';
        break;
    }
    return str;
  }

  static String parseHourAndMin(int time) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time);
    return '${twoDigits(dateTime.hour)}:${twoDigits(dateTime.minute)}';
  }

  static String parseHourAndMinAndSecond(int time) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time);
    return '${twoDigits(dateTime.hour)}:${twoDigits(dateTime.minute)}:${twoDigits(dateTime.second)}';
  }

  static String parseYearAndMonthAndDay(int time) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time);
    return '${dateTime.year} ${twoDigits(dateTime.month)} ${twoDigits(dateTime.day)}';
  }

  static String twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }

  static DateTime startOfDay(DateTime now) {
    return DateTime(now.year, now.month, now.day);
  }

  /// '2020-12-20' 返回当天的这个时间
  static DateTime parseYearAndMonthAndDayWithString(String day) {
    List<String> str = day.split('-');
    return DateTime(int.parse(str[0]), int.parse(str[1]), int.parse(str[2]));
  }

  ///根据给定时间获取当前月的第一天
  static DateTime getFirstDayOfMonth(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, 1);
  }

  ///获取从 2020 年 1月份 之后的所有 月份 第一天
  static List<DateTime> getMonthsSince2020() {
    List<DateTime> months = [];
    int i = 1;
    while (DateTime(2020, i, 1).microsecondsSinceEpoch <
        DateTime.now().microsecondsSinceEpoch) {
      months.add(DateTime(2020, i, 1));
      i++;
    }
    return months;
  }

  /// 0-5 晚上
  /// 5 - 9 早上
  /// 9-12 上午
  /// 12-14 中午
  /// 14-18 下午
  /// 18- 24 晚上
  static String getNowTimeString() {
    int hour = DateTime.now().hour;
    String time = '';
    if (hour >= 5 && hour < 9) {
      time = '早上';
    } else if (hour >= 9 && hour < 12) {
      time = '上午';
    } else if (hour >= 12 && hour < 14) {
      time = '中午';
    } else if (hour >= 14 && hour < 18) {
      time = '下午';
    } else {
      time = '晚上';
    }
    return time;
  }

  static String getNowString() {
    DateTime now = DateTime.now();
    return '${now.year}年${now.month}月${now.day}日';
  }

  static int filterCreateDays(List<int> completeDays, DateTime createTime,
      DateTime startTime, DateTime endTime) {
    createTime = startOfDay(createTime);
    endTime = startOfDay(endTime);
    startTime = startOfDay(startTime);
    Duration duration = Duration(
        milliseconds: createTime.millisecondsSinceEpoch -
            startTime.millisecondsSinceEpoch);
    int dayNum;
    if (duration.inDays >= 0) {
      dayNum = Duration(
                  milliseconds: endTime.millisecondsSinceEpoch -
                      createTime.millisecondsSinceEpoch)
              .inDays +
          1;
      dayNum = List.generate(
              dayNum,
              (index) => DateTime(
                  createTime.year, createTime.month, createTime.day + index))
          .where((day) => completeDays.contains(day.weekday))
          .length;
    } else {
      dayNum = Duration(
                  milliseconds: endTime.millisecondsSinceEpoch -
                      startTime.millisecondsSinceEpoch)
              .inDays +
          1;
      dayNum = List.generate(
              dayNum,
              (index) => DateTime(
                  startTime.year, startTime.month, startTime.day + index))
          .where((day) => completeDays.contains(day.weekday))
          .length;
    }
    return dayNum;
  }
}
