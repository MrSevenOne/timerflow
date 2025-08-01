class TariffModel {
  final String? id;
  final DateTime? createdAt;
  final String name;
  final double price;
  final int maxTables;
  final int maxProducts;
  final int durationDays;
  final DateTime? updatedAt;

  TariffModel({
    this.id,
    this.createdAt,
    required this.name,
    required this.price,
    required this.maxTables,
    required this.maxProducts,
    required this.durationDays,
    this.updatedAt,
  });

  factory TariffModel.fromJson(Map<String, dynamic> json) {
    return TariffModel(
      id: json['id'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      maxTables: json['max_tables'] as int,
      maxProducts: json['max_products'] as int,
      durationDays: json['duration_days'] as int,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'price': price,
      'max_tables': maxTables,
      'max_products': maxProducts,
      'duration_days': durationDays,
      if (createdAt != null) 'created_at': createdAt!.toIso8601String(),
      if (updatedAt != null) 'updated_at': updatedAt!.toIso8601String(),
    };
  }

  TariffModel copyWith({
    String? id,
    DateTime? createdAt,
    String? name,
    double? price,
    int? maxTables,
    int? maxProducts,
    int? durationDays,
    DateTime? updatedAt,
  }) {
    return TariffModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      price: price ?? this.price,
      maxTables: maxTables ?? this.maxTables,
      maxProducts: maxProducts ?? this.maxProducts,
      durationDays: durationDays ?? this.durationDays,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}