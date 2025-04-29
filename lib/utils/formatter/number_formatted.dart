import 'package:intl/intl.dart';

class NumberFormatter {
  static String price(int number) {
    final formatter = NumberFormat('#,###', 'uz_UZ');
    return formatter.format(number);
  }
}
