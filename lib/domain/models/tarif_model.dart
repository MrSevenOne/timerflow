class TariffModel {
  final int id;
  final DateTime createdAt;
  final String subscriptionType;
  final int price;

  TariffModel({
    required this.id,
    required this.createdAt,
    required this.subscriptionType,
    required this.price,
  });

  factory TariffModel.fromJson(Map<String, dynamic> json) {
    return TariffModel(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      subscriptionType: json['subscription_type'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'subscription_type': subscriptionType,
      'price': price,
    };
  }

  TariffModel copyWith({
    int? id,
    DateTime? createdAt,
    String? subscriptionType,
    int? price,
  }) {
    return TariffModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      subscriptionType: subscriptionType ?? this.subscriptionType,
      price: price ?? this.price,
    );
  }
}
