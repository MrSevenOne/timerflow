class DrinkModel {
  final int? id;
  final String name;
  final int price;
  final dynamic volume;
  final int amount;

  DrinkModel({
    this.id,
    required this.name,
    required this.price,
    required this.volume,
    required this.amount,
  });

  factory DrinkModel.fromJson(Map<String, dynamic> json) {
    return DrinkModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      volume: json['volume'],
      amount: json['amount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'volume': volume,
      'amount': amount,
    };
  }

  DrinkModel copyWith({
    int? id,
    String? name,
    int? price,
    dynamic volume,
    int? amount,
  }) {
    return DrinkModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      volume: volume ?? this.volume,
      amount: amount ?? this.amount,
    );
  }
}
