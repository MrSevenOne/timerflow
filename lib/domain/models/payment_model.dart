import 'package:get/get_utils/get_utils.dart';
import 'package:timerflow/domain/models/table_model.dart';
import 'package:timerflow/utils/formatter/date_formatter.dart';
import 'package:timerflow/utils/formatter/number_formatted.dart';

class PaymentReportModel {
  final int? id;
  final int paymentSum;
  final int paymentType;
  final String? description;
  final int orderSum;
  final int tableSum;
  final DateTime createTime;
  final int totalSum;
  final int sessionReportId;
  final String userId;
  final int tableId;
  final TableModel? tableModel;

  PaymentReportModel({
    this.id,
    required this.paymentSum,
    required this.paymentType,
    required this.description,
    required this.orderSum,
    required this.tableSum,
    required this.createTime,
    required this.totalSum,
    required this.sessionReportId,
    required this.userId,
    required this.tableId,
    this.tableModel,
  });

  String get TablePrice => '${NumberFormatter.price(tableSum)} so\'m';
  String get OrderPrice => '${NumberFormatter.price(orderSum)} so\'m';
  String get TotalPrice => '${NumberFormatter.price(totalSum)} so\'m';
  String get PaymentPrice => '${NumberFormatter.price(paymentSum)} so\'m';
  String get PaymentTime => DateFormatter.formatWithMonth(date: createTime);

  // ignore: non_constant_identifier_names
  String get PaymentType {
    switch (paymentType) {
      case 1:
        return 'cash'.tr;
      case 2:
        return 'click'.tr;
      default:
        return 'unknown'.tr;
    }
  }

  factory PaymentReportModel.fromJson(Map<String, dynamic> json) {
    return PaymentReportModel(
      id: json['id'],
      paymentSum: json['payment_sum'],
      paymentType: json['payment_type'],
      description: json['description'] ?? '',
      orderSum: json['order_sum'],
      tableSum: json['table_sum'],
      createTime: DateTime.parse(
          json['created_at'] ?? DateTime.now().toIso8601String()),
      totalSum: json['total_sum'],
      sessionReportId: json['session_report_id'],
      userId: json['user_id'],
      tableId: json['table_id'],
      tableModel:
          json['tables'] != null ? TableModel.fromJson(json['tables']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'payment_sum': paymentSum,
      'payment_type': paymentType,
      'description': description,
      'order_sum': orderSum,
      'table_sum': tableSum,
      'create_time': createTime.toIso8601String(),
      'total_sum': totalSum,
      'session_report_id': sessionReportId,
      'user_id': userId,
      'table_id': tableId,
    };
  }

  PaymentReportModel copyWith({
    int? id,
    int? paymentSum,
    int? paymentType,
    String? description,
    int? orderSum,
    int? tableSum,
    DateTime? createTime,
    int? totalSum,
    int? sessionReportId,
    String? userId,
    int? tableId,
    TableModel? tableModel,
  }) {
    return PaymentReportModel(
      id: id ?? this.id,
      paymentSum: paymentSum ?? this.paymentSum,
      paymentType: paymentType ?? this.paymentType,
      description: description ?? this.description,
      orderSum: orderSum ?? this.orderSum,
      tableSum: tableSum ?? this.tableSum,
      createTime: createTime ?? this.createTime,
      totalSum: totalSum ?? this.totalSum,
      sessionReportId: sessionReportId ?? this.sessionReportId,
      userId: userId ?? this.userId,
      tableId: tableId ?? this.tableId,
      tableModel: tableModel ?? this.tableModel,
    );
  }
}
