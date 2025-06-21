import 'package:timerflow/domain/models/drink_model.dart';
import 'package:timerflow/utils/formatter/date_formatter.dart';

class DrinkReportModel {
  final int? id;
  final DateTime? createdAt;
  final int drinkId;
  final int price;
  final int quantity; // amount o‘rniga
  final int sessionReportId;
    final DrinkModel? drinkModel;

  DrinkReportModel({
    this.id,
    this.createdAt,
    required this.drinkId,
    required this.price,
    required this.quantity,
    required this.sessionReportId,
    this.drinkModel,
  });
      String get formattStartTime => DateFormatter.formatWithMonth(date: createdAt!);


  factory DrinkReportModel.fromJson(Map<String, dynamic> json) {
    return DrinkReportModel(
      id: json['id'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      drinkId: json['drink_id'] ?? 0,
      price: json['price'] ?? 0,
      quantity: json['quantity'] ?? 0,
      sessionReportId: json['session_report_id'] ?? 0,
      drinkModel: json['drink'] != null ? DrinkModel.fromJson(json['drink']) : null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'drink_id': drinkId,
      'price': price,
      'quantity': quantity,
      'session_report_id': sessionReportId,
    };
  }
}
