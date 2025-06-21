import 'package:timerflow/domain/models/food_model.dart';
import 'package:timerflow/utils/formatter/date_formatter.dart';
import 'package:timerflow/utils/formatter/number_formatted.dart';

class FoodReportModel {
  final int? id;
  final DateTime? createdAt;
  final int foodId;
  final int quantity;
  final int sessionReportId;
  final String? userId;
  final FoodModel? foodModel;

  FoodReportModel({
    this.id,
    this.createdAt,
    required this.foodId,
    required this.quantity,
    required this.sessionReportId,
    this.userId,
    this.foodModel,
  });

    String get formattStartTime => DateFormatter.formatWithMonth(date: createdAt!);


  factory FoodReportModel.fromJson(Map<String, dynamic> json) {
    return FoodReportModel(
      id: json['id'] as int?,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      foodId: json['food_id'] ?? 0,
      quantity: json['quantity'] ?? 0,
      sessionReportId: json['session_report_id'] ?? 0,
      userId: json['user_id'],
      foodModel: json['food'] != null
          ? FoodModel.fromJson(json['food'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'food_id': foodId,
      'quantity': quantity,
      'session_report_id': sessionReportId,
      'user_id': userId,
    };
  }

}
