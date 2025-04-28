import 'package:intl/intl.dart';

class DateFormatter {
  static String format({required DateTime date}) {
    final formatter = DateFormat('HH:mm dd MMM');
    return formatter.format(date);
  }
}
