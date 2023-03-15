import 'package:intl/intl.dart';

class Helper {
  static String getDaySuffix({required int day}) {
    switch (day) {
      case 1:
      case 21:
      case 31:
        return 'st';
      case 2:
      case 22:
        return 'nd';
      case 3:
      case 23:
        return 'rd';
      default:
        return 'th';
    }
  }

  static String formatDate({required DateTime date}) {
    final day = date.day;
    final month = DateFormat.MMMM().format(date);
    final year = date.year;
    final suffix = Helper.getDaySuffix(day: day);
    return '$day$suffix $month $year';
  }
}
