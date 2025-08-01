import 'package:timerflow/domain/models/products_model.dart';
import 'package:timerflow/domain/models/table_model.dart';

class ProductReportModel {
  final String id;
  final String userId;
  final String productId;
  final DateTime createdAt;
  final int quantity;
  final DateTime orderTime;
  final String tableId;

  // Optional: Related models (nullable)
  final ProductModel? product;
  final TableModel? tableModel;

  ProductReportModel({
    required this.id,
    required this.userId,
    required this.productId,
    required this.createdAt,
    required this.quantity,
    required this.orderTime,
    required this.tableId,
    this.product,
    this.tableModel,
  });

  factory ProductReportModel.fromJson(Map<String, dynamic> json) {
    return ProductReportModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      productId: json['product_id'] as String,
      createdAt: DateTime.parse(json['created_at']),
      quantity: json['quantity'] as int,
      orderTime: DateTime.parse(json['order_time']),
      tableId: json['table_id'] as String,
      product: json['products'] != null ? ProductModel.fromJson(json['products']) : null,
      tableModel: json['tables'] != null ? TableModel.fromJson(json['tables']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'product_id': productId,
      'created_at': createdAt.toIso8601String(),
      'quantity': quantity,
      'order_time': orderTime.toIso8601String(),
      'table_id': tableId,
    };
  }
}
