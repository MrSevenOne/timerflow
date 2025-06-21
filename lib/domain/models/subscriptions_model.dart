class SubscriptionModel {
  final int id;
  final DateTime createdAt;
  final String userId;
  final int subscriptionTypeId;
  final DateTime startDate;
  final DateTime endDate;
  final int status;
  final int paymentSum;

  SubscriptionModel({
    required this.id,
    required this.createdAt,
    required this.userId,
    required this.subscriptionTypeId,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.paymentSum,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      userId: json['user_id'],
      subscriptionTypeId: json['subscription_type_id'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      status: json['status'],
      paymentSum: json['payment_sum'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'user_id': userId,
      'subscription_type_id': subscriptionTypeId,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'status': status,
      'payment_sum': paymentSum,
    };
  }

  SubscriptionModel copyWith({
    int? id,
    DateTime? createdAt,
    String? userId,
    int? subscriptionTypeId,
    DateTime? startDate,
    DateTime? endDate,
    int? status,
    int? paymentSum,
  }) {
    return SubscriptionModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
      subscriptionTypeId: subscriptionTypeId ?? this.subscriptionTypeId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
      paymentSum: paymentSum ?? this.paymentSum,
    );
  }
}
