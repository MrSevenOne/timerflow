// ignore_for_file: non_constant_identifier_names
import 'package:timerflow/domain/models/table_model.dart';

class SessionModel {
  int? id;
  int table_id;
  DateTime start_time;
  TableModel? tableModel;

  SessionModel({
    this.id,
    required this.table_id,
    required this.start_time,
    this.tableModel,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      id: json['id'],
      table_id: json['table_id'],
      start_time: DateTime.parse(json['start_time']),
      tableModel: json['tables'] != null
          ? TableModel.fromJson(json['tables'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'table_id': table_id,
      'start_time': start_time.toIso8601String(),
    };
  }
}
