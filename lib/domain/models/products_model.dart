// lib/domain/models/product_model.dart
class ProductModel {
  final String? id;
  final String userId;
  final String name;
  final int price;
  final String type;
  final int amount;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ProductModel({
    this.id,
    required this.userId,
    required this.name,
    required this.price,
    required this.type,
    required this.amount,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      price: json['price'],
      type: json['type'],
      amount: json['amount'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at']).toLocal()
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at']).toLocal()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'name': name,
      'price': price,
      'type': type,
      'amount': amount,
    };
  }

  ProductModel copyWith({
    String? id,
    String? userId,
    String? name,
    int? price,
    String? type,
    int? amount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProductModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      price: price ?? this.price,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
