class UserModel {
  final String? id;
  final DateTime createdAt;
  final String name;
  final String email;
  final String password;
  final bool status;

  UserModel({
    this.id,
    required this.createdAt,
    required this.name,
    required this.email,
    required this.password,
    required this.status,
  });

  /// ----------- COPYWITH -----------
  UserModel copyWith({
    String? id,
    DateTime? createdAt,
    String? name,
    String? email,
    String? password,
    bool? status,
  }) {
    return UserModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  /// ----------- FROM JSON -----------
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      name: json['name'],
      email: json['email'],
      password: json['password'],
      status: json['status'] ?? false,
    );
  }

  /// ----------- TO JSON -----------
  Map<String, dynamic> toJson() {
    return {
      if (id != null) "id": id,
      "created_at": createdAt.toIso8601String(),
      "name": name,
      "email": email,
      "password": password,
      "status": status,
    };
  }
}
