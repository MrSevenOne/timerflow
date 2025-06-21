class UserModel {
  final int? id;
  final DateTime? createTime;
  final String? authId;
  final String username;
  final String email;
  final String password;
  final int? subscriptionId;
  final String status;

  UserModel({
    this.id,
    this.createTime,
    this.authId,
    required this.username,
    required this.email,
    required this.password,
    this.subscriptionId,
    required this.status,
  });

  // 🔁 FROM JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int?,
      createTime: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      authId: json['auth_id'] as String?,
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      subscriptionId: json['subscription_id'] as int?,
      status: json['status'] ?? '',
    );
  }

  // 🔁 TO JSON
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (authId != null) 'auth_id': authId,
      'username': username,
      'email': email,
      'password': password,
      if (subscriptionId != null) 'subscription_id': subscriptionId,
      'status': status,
    };
  }

  // 📄 COPYWITH
  UserModel copyWith({
    int? id,
    DateTime? createTime,
    String? authId,
    String? username,
    String? email,
    String? password,
    int? subscriptionId,
    String? status,
  }) {
    return UserModel(
      id: id ?? this.id,
      createTime: createTime ?? this.createTime,
      authId: authId ?? this.authId,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      subscriptionId: subscriptionId ?? this.subscriptionId,
      status: status ?? this.status,
    );
  }
}
