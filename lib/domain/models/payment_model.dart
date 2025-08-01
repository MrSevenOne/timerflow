import 'package:timerflow/utils/formatter/number_formatted.dart';

class PaymentModel {
  final String? id;
  final DateTime? createdAt;
  final String userId;
  final String tableReportId;
  final double tableTimeAmount;
  final double productsAmount;
  final double totalAmount;
  final DateTime? paymentTime;

  PaymentModel({
    this.id,
    this.createdAt,
    required this.userId,
    required this.tableReportId,
    required this.tableTimeAmount,
    required this.productsAmount,
    required this.totalAmount,
    this.paymentTime,
  });

  String get totalPrice => NumberFormatter.price(totalAmount);
  String get totaltableTimeAmount => NumberFormatter.price(tableTimeAmount);
  String get totalproductsAmount => NumberFormatter.price(productsAmount);

  /// ✅ Supabase'dan vaqtni local formatga o'tkazish
  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: json['id'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String).toLocal()
          : null,
      userId: json['user_id'] as String,
      tableReportId: json['table_report_id'] as String,
      tableTimeAmount: (json['table_time_amount'] as num).toDouble(),
      productsAmount: (json['products_amount'] as num).toDouble(),
      totalAmount: (json['total_amount'] as num).toDouble(),
      paymentTime: json['payment_time'] != null
          ? DateTime.parse(json['payment_time'] as String).toLocal()
          : null,
    );
  }

  /// ✅ Supabase'ga UTC formatda vaqt yuborish
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'user_id': userId,
      'table_report_id': tableReportId,
      'table_time_amount': tableTimeAmount,
      'products_amount': productsAmount,
      'total_amount': totalAmount,
      if (paymentTime != null)
        'payment_time': paymentTime!.toUtc().toIso8601String(),
      if (createdAt != null) 'created_at': createdAt!.toUtc().toIso8601String(),
    };
  }

  /// ✅ copyWith - obyektni klonlash uchun
  PaymentModel copyWith({
    String? id,
    DateTime? createdAt,
    String? userId,
    String? tableReportId,
    double? tableTimeAmount,
    double? productsAmount,
    double? totalAmount,
    DateTime? paymentTime,
  }) {
    return PaymentModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
      tableReportId: tableReportId ?? this.tableReportId,
      tableTimeAmount: tableTimeAmount ?? this.tableTimeAmount,
      productsAmount: productsAmount ?? this.productsAmount,
      totalAmount: totalAmount ?? this.totalAmount,
      paymentTime: paymentTime ?? this.paymentTime,
    );
  }
}
