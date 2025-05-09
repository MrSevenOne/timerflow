class PaymentReportModel {
  final int? id;
  final int paymentSum;
  final int paymentType;
  final String description;
  final int orderSum;
  final int tableSum;
  final DateTime createTime;
  final int totalSum;
  final int sessionReportId;

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
  });

  factory PaymentReportModel.fromJson(Map<String, dynamic> json) {
    return PaymentReportModel(
      id: json['id'],
      paymentSum: json['payment_sum'],
      paymentType: json['payment_type'],
      description: json['description'],
      orderSum: json['order_sum'],
      tableSum: json['table_sum'],
      createTime: json['create_time'],
      totalSum: json['total_sum'],
      sessionReportId: json['session_report_id'],
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
    );
  }
}
