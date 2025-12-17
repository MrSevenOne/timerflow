import 'package:hive/hive.dart';

part 'table_model.g.dart';

@HiveType(typeId: 0)
class TableModel extends HiveObject {
  @HiveField(0)
  int id; // UUID bo‘ldi (offline + online uchun yagona)

  @HiveField(1)
  String name;

  @HiveField(2)
  String type;

  @HiveField(3)
  int hourPrice;

  @HiveField(4)
  bool isActive;

  @HiveField(5)
  DateTime createdAt;

  @HiveField(6)
  DateTime updatedAt;

  @HiveField(7)
  String userId;

  @HiveField(8)
  bool isSynced; // local → server

  TableModel({
    int? id,
    required this.name,
    required this.type,
    required this.hourPrice,
    this.isActive = true,
    DateTime? createdAt,
    DateTime? updatedAt,
    required this.userId,
    this.isSynced = false,
  })  : id = id??0,
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory TableModel.fromJson(Map<String, dynamic> json) {
    return TableModel(
      id: json['id'] as int,
      name: json['name'] as String,
      type: json['type'] as String,
      hourPrice: json['hour_price'] as int,
      isActive: json['is_active'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      userId: json['user_id'] as String,
      isSynced: true, // server’dan kelgan ma’lumot har doim synced
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'hour_price': hourPrice,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'user_id': userId,
    };
  }

  TableModel copyWith({
    int? id,
    String? name,
    String? type,
    int? hourPrice,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? userId,
    bool? isSynced,
  }) {
    return TableModel(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      hourPrice: hourPrice ?? this.hourPrice,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
      userId: userId ?? this.userId,
      isSynced: isSynced ?? this.isSynced,
    );
  }
}
