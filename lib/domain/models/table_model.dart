import 'package:timerflow/utils/formatter/date_formatter.dart';
import 'package:timerflow/utils/formatter/number_formatted.dart';

class TableModel {
  final String? id;
  final DateTime? createdAt;
  final String userId;
  final String name;
  final int number;
  final String type; // 'billiard' or 'tennis'
  final double pricePerHour;
  final String status; // 'free', 'busy', 'completed'
  final DateTime? updatedAt;

  TableModel({
    this.id,
    this.createdAt,
    required this.userId,
    required this.name,
    required this.number,
    required this.type,
    required this.pricePerHour,
    required this.status,
    this.updatedAt,
  });

  // ✅ Local formatda soat ko‘rsatish
  String get formattedStartTime => 
      updatedAt != null ? DateFormatter.formatTime(time: updatedAt!) : "00:00";

  // ✅ To‘g‘ri duration hisoblash (extra offset YUQ)
  String get formattedDuration {
    if (updatedAt == null) return "00:00";

    final duration = DateTime.now().difference(updatedAt!);
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;

    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(hours)}:${twoDigits(minutes)}";
  }


  // ✅ Formatlangan narx (10 000)
  String get formattedPricePerHour => NumberFormatter.price(pricePerHour);

  // ✅ Supabase'dan vaqt o‘qishda .toLocal() ishlatilmoqda
  factory TableModel.fromJson(Map<String, dynamic> json) {
    return TableModel(
      id: json['id'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String).toLocal()
          : null,
      userId: json['user_id'] as String,
      name: json['name'] as String,
      number: json['number'] as int,
      type: json['type'] as String,
      pricePerHour: (json['price_per_hour'] as num).toDouble(),
      status: json['status'] as String,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String).toLocal()
          : null,
    );
  }

  // ✅ Supabase'ga UTC formatda yozilmoqda
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'user_id': userId,
      'name': name,
      'number': number,
      'type': type,
      'price_per_hour': pricePerHour,
      'status': status,
      if (createdAt != null) 'created_at': createdAt!.toUtc().toIso8601String(),
      if (updatedAt != null) 'updated_at': updatedAt!.toUtc().toIso8601String(),
    };
  }

  TableModel copyWith({
    String? id,
    DateTime? createdAt,
    String? userId,
    String? name,
    int? number,
    String? type,
    double? pricePerHour,
    String? status,
    DateTime? updatedAt,
  }) {
    return TableModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      number: number ?? this.number,
      type: type ?? this.type,
      pricePerHour: pricePerHour ?? this.pricePerHour,
      status: status ?? this.status,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
