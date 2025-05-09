class SessionReportModel {
  final int? id;
  final DateTime? startTime;
  final DateTime endTime;
  final int? tableId;
  final String duration;
  final int tablePrice;
  final int orderPrice;
  final int sessionId;

  SessionReportModel({
    this.id,
    required this.startTime,
    required this.endTime,
    this.tableId,
    required this.duration,
    required this.tablePrice,
    required this.orderPrice,
    required this.sessionId,
  });

  factory SessionReportModel.fromJson(Map<String, dynamic> json) {
    return SessionReportModel(
      id: json['id'],
      startTime: DateTime.parse(json['start_time']),
      endTime: DateTime.parse(json['end_time']),
      tableId: json['table_id'],
      duration: json['duration'],
      tablePrice: json['table_price'],
      orderPrice: json['order_price'],
      sessionId: json['session_id']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'end_time': endTime.toIso8601String(),
      'table_id': tableId,
      'duration': duration.toString(),
      'table_price': tablePrice,
      'order_price': orderPrice,
      'session_id': sessionId,
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
  }) {
    return SessionReportModel(
      id: id ?? this.id,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      tablePrice: tablePrice ?? this.tablePrice,
      tableId: tableId ?? this.tableId,
      duration: duration ?? this.duration,
      orderPrice: orderPrice ?? this.orderPrice,
      sessionId:  sessionId ?? this.sessionId,
    );
  }
}
