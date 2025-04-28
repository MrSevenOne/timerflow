import 'package:intl/intl.dart';

class NumberFormatter {
  static String format(int number) {
    final formatter = NumberFormat('#,##0', 'uz_UZ');
    return formatter.format(number);
  }
}
