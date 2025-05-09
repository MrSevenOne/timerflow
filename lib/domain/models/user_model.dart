class UserModel {
  final int? id;
  final DateTime? createTime;
  final String? authId;
  final String username;
  final String email;
  final String password;
  final bool status;

  UserModel({
    this.id,
    this.createTime,
    this.authId,
    required this.username,
    required this.email,
    required this.password,
    required this.status,
  });

  // From JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      createTime: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      authId: json['auth_id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      status: json['status'],
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'status': status,
    };
  }

  // CopyWith
  UserModel copyWith({
    int? id,
    DateTime? createTime,
    String? authId,
    String? username,
    String? email,
    String? password,
    bool? status,
  }) {
    return UserModel(
      id: id ?? this.id,
      createTime: createTime ?? this.createTime,
      authId: authId ?? this.authId,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }
}
