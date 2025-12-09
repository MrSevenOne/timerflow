// lib/models/table_model.dart

import 'package:hive/hive.dart';


@HiveType(typeId: 0)
class TableModel extends HiveObject {
  // Supabase/Server ID (BIGINT)
  @HiveField(0)
  int? id;

  // Lokal unikal ID (har doim mavjud): server id bo'lsa id.toString(), aks holda UUID yoki timestamp
  @HiveField(1)
  String localId;

  @HiveField(2)
  String name;

  @HiveField(3)
  String type;

  @HiveField(4)
  int hourPrice;

  @HiveField(5)
  bool isActive;

  @HiveField(6)
  DateTime createdAt;

  @HiveField(7)
  DateTime updatedAt;

  @HiveField(8)
  String userId;

  // OFFLINE-FIRST USTUNLARI
  @HiveField(9)
  bool isSynced;

  @HiveField(10)
  bool isDirty;

  @HiveField(11)
  bool isDeletedLocally;

  TableModel({
    this.id,
    required this.localId,
    required this.name,
    required this.type,
    required this.hourPrice,
    required this.userId,
    this.isActive = true,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.isSynced = false,
    this.isDirty = false,
    this.isDeletedLocally = false,
  })  : createdAt = createdAt?.toUtc() ?? DateTime.now().toUtc(),
        updatedAt = updatedAt?.toUtc() ?? DateTime.now().toUtc();

  // --- Factory from Supabase map ---
  factory TableModel.fromMap(Map<String, dynamic> map) {
    // Supabase sometimes returns timestamps as DateTime already; handle both
    DateTime parseTs(dynamic v) {
      if (v == null) return DateTime.now().toUtc();
      if (v is DateTime) return v.toUtc();
      return DateTime.parse(v.toString()).toUtc();
    }

    final serverId = map['id'] is int ? map['id'] as int : int.tryParse(map['id'].toString());
    final localId = serverId != null ? serverId.toString() : (map['localId']?.toString() ?? DateTime.now().toUtc().toIso8601String());

    return TableModel(
      id: serverId,
      localId: localId,
      name: map['name'] as String? ?? '',
      type: map['type'] as String? ?? '',
      hourPrice: (map['hour_price'] is int) ? map['hour_price'] as int : int.tryParse(map['hour_price']?.toString() ?? '0') ?? 0,
      isActive: (map['is_active'] is bool) ? map['is_active'] as bool : (map['is_active']?.toString().toLowerCase() == 'true'),
      userId: map['user_id']?.toString() ?? '',
      createdAt: parseTs(map['created_at']),
      updatedAt: parseTs(map['updated_at']),
      isSynced: true,
      isDirty: false,
      isDeletedLocally: false,
    );
  }

  // --- Map for Supabase (server) ---
  Map<String, dynamic> toMapForServer() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'type': type,
      'hour_price': hourPrice,
      'is_active': isActive,
      'user_id': userId,
      // don't send created_at/updated_at unless you specifically want to override server timestamps
    };
  }

  // --- copyWith including flags ---
  TableModel copyWith({
    int? id,
    String? localId,
    String? name,
    String? type,
    int? hourPrice,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? userId,
    bool? isSynced,
    bool? isDirty,
    bool? isDeletedLocally,
  }) {
    return TableModel(
      id: id ?? this.id,
      localId: localId ?? this.localId,
      name: name ?? this.name,
      type: type ?? this.type,
      hourPrice: hourPrice ?? this.hourPrice,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
      isSynced: isSynced ?? this.isSynced,
      isDirty: isDirty ?? this.isDirty,
      isDeletedLocally: isDeletedLocally ?? this.isDeletedLocally,
    );
  }
}





class TableModelAdapter extends TypeAdapter<TableModel> {
  @override
  final int typeId = 0;

  @override
  TableModel read(BinaryReader reader) {
    return TableModel(
      id: reader.read() as int?,
      localId: reader.read() as String,
      name: reader.read() as String,
      type: reader.read() as String,
      hourPrice: reader.read() as int,
      isActive: reader.read() as bool,
      createdAt: reader.read() as DateTime,
      updatedAt: reader.read() as DateTime,
      userId: reader.read() as String,
      isSynced: reader.read() as bool,
      isDirty: reader.read() as bool,
      isDeletedLocally: reader.read() as bool,
    );
  }

  @override
  void write(BinaryWriter writer, TableModel obj) {
    writer.write(obj.id);
    writer.write(obj.localId);
    writer.write(obj.name);
    writer.write(obj.type);
    writer.write(obj.hourPrice);
    writer.write(obj.isActive);
    writer.write(obj.createdAt);
    writer.write(obj.updatedAt);
    writer.write(obj.userId);
    writer.write(obj.isSynced);
    writer.write(obj.isDirty);
    writer.write(obj.isDeletedLocally);
  }
}
