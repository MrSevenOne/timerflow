import 'package:timerflow/utils/formatter/number_formatted.dart';

class FoodModel {
  final int? id;
  final String name;
  final int price;
  final int amount;
  final String userId;

  FoodModel({
    this.id,
    required this.name,
    required this.price,
    required this.amount,
    required this.userId,
  });
  String get formattedPrice => '${NumberFormatter.price(price)} so\'m';

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      id: json['id'] as int?,
      name: json['name'] as String,
      price: json['price'],
      amount: json['amount'],
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'amount': amount,
      'user_id': userId,
    };
  }

  FoodModel copyWith({
    int? id,
    String? name,
    int? price,
    int? amount,
    String? userId,
  }) {
    return FoodModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      amount: amount!,
      userId: userId ?? this.userId,
    );
  }
}
