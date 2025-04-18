class ReportModel {
  final int? id;
  final int tableId;
  final DateTime startTime;
  final DateTime endTime;
  final double duration;
  final double totalAmount;

  ReportModel({
    this.id,
    required this.tableId,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.totalAmount,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['id'],
      tableId: json['table_id'],
      startTime: DateTime.parse(json['start_time']),
      endTime: DateTime.parse(json['end_time']),
      duration: (json['duration'] as num).toDouble(),
      totalAmount: (json['total_amount'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'table_id': tableId,
      'start_time': startTime,
      'end_time': endTime,
      'duration': duration,
      'total_amount': totalAmount,
    };
  }
}
