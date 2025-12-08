class UserTariffModel {
  final int id;
  final DateTime createdAt;
  final String userId;
  final int tariffId;
  final bool status;

  UserTariffModel({
    required this.id,
    required this.createdAt,
    required this.userId,
    required this.tariffId,
    required this.status,
  });

  factory UserTariffModel.fromMap(Map<String, dynamic> map) {
    return UserTariffModel(
      id: map['id'],
      createdAt: DateTime.parse(map['created_at']),
      userId: map['user_id'],
      tariffId: map['tariff_id'],
      status: map['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'user_id': userId,
      'tariff_id': tariffId,
      'status': status,
    };
  }
}
