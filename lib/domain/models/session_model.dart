class SessionModel {
  final String? id;
  final DateTime? createdAt;
  final String userId;
  final String tableId;
  final DateTime startTime;
  final DateTime endTime;
  final double totalTime;
  final DateTime updatedAt;

  SessionModel({
    this.id,
    this.createdAt,
    required this.userId,
    required this.tableId,
    required this.startTime,
    required this.endTime,
    required this.totalTime,
    required this.updatedAt,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
  return SessionModel(
    id: json['id'] as String?,
    createdAt: json['created_at'] != null
        ? DateTime.parse(json['created_at'] as String)
        : null,
    userId: json['user_id'] as String,
    tableId: json['table_id'] as String,
    startTime: DateTime.parse(json['start_time'] as String),
    endTime: DateTime.parse(json['end_time'] as String), // ✅ TO‘G‘RILANGAN
    totalTime: (json['total_time'] as num).toDouble(),
    updatedAt: DateTime.parse(json['updated_at'] as String), // ✅ TO‘G‘RILANGAN
  );
}


  Map<String, dynamic> toJson() {
  return {
    if (id != null) 'id': id,
    'user_id': userId,
    'table_id': tableId,
    'start_time': startTime.toIso8601String(),
    'end_time': endTime.toIso8601String(),
    'total_time': totalTime,
    'created_at': (createdAt ?? DateTime.now()).toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };
}


  SessionModel copyWith({
    String? id,
    DateTime? createdAt,
    String? userId,
    String? tableId,
    DateTime? startTime,
    DateTime? endTime,
    double? totalTime,
    DateTime? updatedAt,
  }) {
    return SessionModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
      tableId: tableId ?? this.tableId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      totalTime: totalTime ?? this.totalTime,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}



