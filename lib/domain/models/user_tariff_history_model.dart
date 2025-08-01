class UserTariffHistoryModel {
  final String? id;
  final DateTime? createdAt;
  final String userId;
  final String tariffId;
  final DateTime? purchaseDate;
  final DateTime startDate;
  final DateTime endDate;
  final double paymentAmount;
  final String? paymentMethod;

  UserTariffHistoryModel({
    this.id,
    this.createdAt,
    required this.userId,
    required this.tariffId,
    this.purchaseDate,
    required this.startDate,
    required this.endDate,
    required this.paymentAmount,
    this.paymentMethod,
  });

  factory UserTariffHistoryModel.fromJson(Map<String, dynamic> json) {
    return UserTariffHistoryModel(
      id: json['id'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      userId: json['user_id'] as String,
      tariffId: json['tariff_id'] as String,
      purchaseDate: json['purchase_date'] != null
          ? DateTime.parse(json['purchase_date'] as String)
          : null,
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
      paymentAmount: (json['payment_amount'] as num).toDouble(),
      paymentMethod: json['payment_method'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'user_id': userId,
      'tariff_id': tariffId,
      if (purchaseDate != null) 
        'purchase_date': purchaseDate!.toIso8601String(),
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'payment_amount': paymentAmount,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (createdAt != null) 'created_at': createdAt!.toIso8601String(),
    };
  }

  UserTariffHistoryModel copyWith({
    String? id,
    DateTime? createdAt,
    String? userId,
    String? tariffId,
    DateTime? purchaseDate,
    DateTime? startDate,
    DateTime? endDate,
    double? paymentAmount,
    String? paymentMethod,
  }) {
    return UserTariffHistoryModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
      tariffId: tariffId ?? this.tariffId,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      paymentAmount: paymentAmount ?? this.paymentAmount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }
}