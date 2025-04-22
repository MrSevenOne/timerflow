class FoodModel {
  final int? id;
  final String name;
  final int price;
  final int amount;

  FoodModel({
    this.id,
    required this.name,
    required this.price,
    required this.amount,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      id: json['id'] as int?,
      name: json['name'] as String,
      price: json['price'],
      amount: json['amount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'amount': amount,
    };
  }

  FoodModel copyWith({
    int? id,
    String? name,
    int? price,
    int? amount,
  }) {
    return FoodModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      amount: amount!,
    );
  }
}
