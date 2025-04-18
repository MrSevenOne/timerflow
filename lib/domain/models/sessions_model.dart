import 'table_model.dart';

class SessionModel {
  final int id;
  final int tableId;
  final DateTime? startTime;
  final TableModel? table; // 🔗 Foreign key object

  SessionModel({
    required this.id,
    required this.tableId,
    this.startTime,
    this.table,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      id: json['id'],
      tableId: json['table_id'],
      startTime: json['start_time'] != null ? DateTime.parse(json['start_time']) : null,
      table: json['tables'] != null ? TableModel.fromJson(json['tables']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'table_id': tableId,
        'start_time': startTime?.toIso8601String(),
        'tables': table?.toJson(), // optional
      };

  SessionModel copyWith({
    int? id,
    int? tableId,
    DateTime? startTime,
    TableModel? table,
  }) {
    return SessionModel(
      id: id ?? this.id,
      tableId: tableId ?? this.tableId,
      startTime: startTime ?? this.startTime,
      table: table ?? this.table,
    );
  }
}
