
class TableModel {
  final int? localId;
  final int? serverId;
  final String name;
  final String type;
  final int hourPrice;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? userId;

  TableModel({
    this.localId,
    this.serverId,
    required this.name,
    required this.type,
    required this.hourPrice,
    this.isActive = true,
    this.createdAt,
    this.updatedAt,
    this.userId,
  });

  TableModel copyWith({
    int? localId,
    int? serverId,
    String? name,
    String? type,
    int? hourPrice,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? userId,
  }) {
    return TableModel(
      localId: localId ?? this.localId,
      serverId: serverId ?? this.serverId,
      name: name ?? this.name,
      type: type ?? this.type,
      hourPrice: hourPrice ?? this.hourPrice,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
    );
  }
}


