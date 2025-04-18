import 'package:intl/intl.dart';

class DateTimeFormatted {
  /// Timeni formatlash M: 14:40
  static String timeFormat({required DateTime time}) {
    String formattedTime = DateFormat.Hm().format(time);
    return formattedTime;
  }

  static String dateFormat({required DateTime dateTime}) {
    String formattedDate = DateFormat('dd.MM.yyyy').format(dateTime);
    return formattedDate;
  }
}