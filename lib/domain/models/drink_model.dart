class DrinkModel {
  final int? id;
  final String name;
  final int price;
  final dynamic volume;
  final int amount;
  final String userId;

  DrinkModel({
    this.id,
    required this.name,
    required this.price,
    required this.volume,
    required this.amount,
    required this.userId,
  });

  factory DrinkModel.fromJson(Map<String, dynamic> json) {
    return DrinkModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      volume: json['volume'],
      amount: json['amount'],
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'volume': volume,
      'amount': amount,
      'user_id': userId,
    };
  }

  DrinkModel copyWith({
    int? id,
    String? name,
    int? price,
    dynamic volume,
    int? amount,
    String? userId,
  }) {
    return DrinkModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      volume: volume ?? this.volume,
      amount: amount ?? this.amount,
      userId:  userId ?? this.userId,
    );
  }
}
