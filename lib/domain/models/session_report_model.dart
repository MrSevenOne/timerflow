import 'package:timerflow/domain/models/table_model.dart';
import 'package:timerflow/utils/formatter/date_formatter.dart';
import 'package:timerflow/utils/formatter/number_formatted.dart';

class SessionReportModel {
  final int? id;
  final DateTime? startTime;
  final DateTime endTime;
  final int? tableId;
  final String duration;
  final int tablePrice;
  final int orderPrice;
  final int sessionId;
  final String userId;
  final TableModel? tableModel;

  SessionReportModel({
    this.id,
    required this.startTime,
    required this.endTime,
    this.tableId,
    required this.duration,
    required this.tablePrice,
    required this.orderPrice,
    required this.sessionId,
    required this.userId,
    this.tableModel,
  });

  /// ✅ FORMATLANGAN VAQTLAR
  String get formattedStartTime =>
      startTime != null ? DateFormatter.formatWithMonth(date: startTime!) : '-';

  String get formattedEndTime => DateFormatter.formatWithMonth(date: endTime);

  /// ✅ FORMATLANGAN NARXLAR
  String get formattedTablePrice => '${NumberFormatter.price(tablePrice)} so\'m';
  String get formattedOrderPrice => '${NumberFormatter.price(orderPrice)} so\'m';
  String get formattedTableTimePrice =>
      '${NumberFormatter.price(tablePrice)} so\'m';
      //formattedDurationFromTimeDiff
      String get formattedDurationFromTimeDiff {
  if (startTime == null || endTime.isBefore(startTime!)) return '-';

  final difference = endTime.difference(startTime!);
  final hours = difference.inHours;
  final minutes = difference.inMinutes.remainder(60);

  if (hours > 0 && minutes > 0) {
    return '$hours:$minutes';
  } else if (hours > 0) {
    return '$hours h';
  } else {
    return '$minutes m';
  }
}


  factory SessionReportModel.fromJson(Map<String, dynamic> json) {
    return SessionReportModel(
      id: json['id'],
      startTime: DateTime.parse(json['start_time']),
      endTime: DateTime.parse(json['end_time']),
      tableId: json['table_id'],
      duration: json['duration'],
      tablePrice: json['table_price'],
      orderPrice: json['order_price'],
      sessionId: json['session_id'],
      userId: json['user_id'],
      tableModel:
          json['tables'] != null ? TableModel.fromJson(json['tables']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'start_time':startTime?.toIso8601String(),
      'end_time': endTime.toIso8601String(),
      'table_id': tableId,
      'duration': duration,
      'table_price': tablePrice,
      'order_price': orderPrice,
      'session_id': sessionId,
      'user_id': userId,
    };
  }

  SessionReportModel copyWith({
    int? id,
    DateTime? startTime,
    DateTime? endTime,
    int? tableId,
    String? duration,
    int? tablePrice,
    int? orderPrice,
    int? sessionId,
    String? userId,
  }) {
    return SessionReportModel(
      id: id ?? this.id,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      tablePrice: tablePrice ?? this.tablePrice,
      tableId: tableId ?? this.tableId,
      duration: duration ?? this.duration,
      orderPrice: orderPrice ?? this.orderPrice,
      sessionId: sessionId ?? this.sessionId,
      userId: userId ?? this.userId,
    );
  }
}
