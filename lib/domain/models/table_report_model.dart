import 'package:timerflow/domain/models/table_model.dart';
import 'package:timerflow/utils/formatter/date_formatter.dart';

class TableReportModel {
  final String id;
  final String userId;
  final String tableId;
  final DateTime startDate;
  final DateTime endDate;
  final double totalHours;
  final double tableRevenue;
  final double productRevenue;
  final double totalRevenue;

  final TableModel? table;

  TableReportModel({
    this.id = '',
    required this.userId,
    required this.tableId,
    required this.startDate,
    required this.endDate,
    required this.totalHours,
    required this.tableRevenue,
    required this.productRevenue,
    required this.totalRevenue,
    this.table,
  });

  String get formattedStartTime =>
      DateFormatter.formatTime(time: startDate.toLocal());

  String get formattedEndTime =>
      DateFormatter.formatTime(time: endDate.toLocal());

  // 🟩 Duration between startDate and endDate (e.g., "2 soat 20 minut")
  String get formattedDuration {
    final duration = endDate.difference(startDate);
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    return '${hours} soat ${minutes} minut';
  }

  factory TableReportModel.fromJson(Map<String, dynamic> json) {
    return TableReportModel(
      id: json['id'] ?? '',
      userId: json['user_id'],
      tableId: json['table_id'],
      startDate: DateTime.parse(json['start_date']).toLocal(),
      endDate: DateTime.parse(json['end_date']).toLocal(),
      totalHours: (json['total_hours'] as num).toDouble(),
      tableRevenue: (json['table_revenue'] as num).toDouble(),
      productRevenue: (json['product_revenue'] as num).toDouble(),
      totalRevenue: (json['total_revenue'] as num).toDouble(),
      table: json['table'] != null ? TableModel.fromJson(json['table']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'table_id': tableId,
      'start_date': startDate.toUtc().toIso8601String(),
      'end_date': endDate.toUtc().toIso8601String(),
      'total_hours': totalHours,
      'table_revenue': tableRevenue,
      'product_revenue': productRevenue,
      'total_revenue': totalRevenue,
    };
  }

  TableReportModel copyWith({
    String? id,
    String? userId,
    String? tableId,
    DateTime? startDate,
    DateTime? endDate,
    double? totalHours,
    double? tableRevenue,
    double? productRevenue,
    double? totalRevenue,
    TableModel? table,
  }) {
    return TableReportModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      tableId: tableId ?? this.tableId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      totalHours: totalHours ?? this.totalHours,
      tableRevenue: tableRevenue ?? this.tableRevenue,
      productRevenue: productRevenue ?? this.productRevenue,
      totalRevenue: totalRevenue ?? this.totalRevenue,
      table: table ?? this.table,
    );
  }
}
