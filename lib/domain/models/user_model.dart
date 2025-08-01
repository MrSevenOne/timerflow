class UserModel {
  final String? id;
  final String? authId;
  final DateTime? createdAt;
  final String name;
  final String email;
  final String password;
  final String? tariffId;
  final DateTime? tariffStartDate;
  final DateTime? tariffEndDate;
  final DateTime? updatedAt;

  UserModel({
    this.id,
    this.createdAt,
    this.authId,
    required this.name,
    required this.email,
    required this.password,
    this.tariffId,
    this.tariffStartDate,
    this.tariffEndDate,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String?,
      authId: json['auth_id'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      tariffId: json['tariff_id'] as String?,
      tariffStartDate: json['tariff_start_date'] != null
          ? DateTime.parse(json['tariff_start_date'] as String)
          : null,
      tariffEndDate: json['tariff_end_date'] != null
          ? DateTime.parse(json['tariff_end_date'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,

    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'email': email,
      'password': password,
      if (tariffId != null) 'tariff_id': tariffId,
      if (tariffStartDate != null)
        'tariff_start_date': tariffStartDate!.toIso8601String(),
      if (tariffEndDate != null)
        'tariff_end_date': tariffEndDate!.toIso8601String(),
      if (createdAt != null) 'created_at': createdAt!.toIso8601String(),
      if (updatedAt != null) 'updated_at': updatedAt!.toIso8601String(),
    };
  }

  UserModel copyWith({
    String? id,
    String? authId,
    DateTime? createdAt,
    String? name,
    String? email,
    String? password,
    String? tariffId,
    DateTime? tariffStartDate,
    DateTime? tariffEndDate,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      authId: authId ?? this.authId,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      tariffId: tariffId ?? this.tariffId,
      tariffStartDate: tariffStartDate ?? this.tariffStartDate,
      tariffEndDate: tariffEndDate ?? this.tariffEndDate,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
