import 'package:timerflow/domain/models/products_model.dart';

class OrderModel {
  final String id;
  final String userId;
  final String productId;
  final String tableId;
  final int quantity;
  final DateTime orderTime;
  final DateTime createdAt;
  final ProductModel? product;

  OrderModel({
    this.id = '',
    required this.userId,
    required this.productId,
    required this.tableId,
    required this.quantity,
    required this.orderTime,
    required this.createdAt,
    this.product,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? '',
      userId: json['user_id'],
      productId: json['product_id'],
      tableId: json['table_id'],
      quantity: json['quantity'],
      orderTime: DateTime.parse(json['order_time']).toLocal(),
      createdAt: DateTime.parse(json['created_at']).toLocal(),

      /// 👇 JOIN qilingan products jadvalidan parse qilish
      product: json['products'] != null
          ? ProductModel.fromJson(json['products'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'product_id': productId,
      'table_id': tableId,
      'quantity': quantity,
      'order_time': orderTime.toUtc().toIso8601String(),
      'created_at': createdAt.toUtc().toIso8601String(),
    };
  }

  OrderModel copyWith({
    String? id,
    String? userId,
    String? productId,
    String? tableId,
    int? quantity,
    DateTime? orderTime,
    DateTime? createdAt,
    ProductModel? product,
  }) {
    return OrderModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      productId: productId ?? this.productId,
      tableId: tableId ?? this.tableId,
      quantity: quantity ?? this.quantity,
      orderTime: orderTime ?? this.orderTime,
      createdAt: createdAt ?? this.createdAt,
      product: product ?? this.product,
    );
  }
}
