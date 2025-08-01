import 'package:intl/intl.dart';

class DateFormatter {
  static String formatWithMonth({required DateTime date}) {
    final formatter = DateFormat('HH:mm dd MMM');
    return formatter.format(date);
  }

  static String formatTime({required DateTime time}) {
    final formatter = DateFormat('HH:mm');
    return formatter.format(time);
  }

 static String formatDuration(Duration duration) {
  final int hours = duration.inHours;
  final int minutes = duration.inMinutes.remainder(60);

  if (hours > 0) {
    return '${_twoDigits(hours)}:${_twoDigits(minutes)}';
  } else {
    return '${_twoDigits(minutes)} minut';
  }
}



static String _twoDigits(int n) => n.toString().padLeft(2, '0');


}
