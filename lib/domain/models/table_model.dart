import 'package:timerflow/utils/formatter/number_formatted.dart';

class TableModel {
  final int? id;
  final DateTime? createTime;
  final String name;
  final int number;
  final int status;
  final int price;
  final String userId;

  TableModel({
    this.id,
    this.createTime,
    required this.name,
    required this.number,
    required this.status,
    required this.price,
    required this.userId,
  });

  /// ✅ Formatlangan narx
  String get formattedPrice => '${NumberFormatter.price(price)} so\'m';

  factory TableModel.fromJson(Map<String, dynamic> json) => TableModel(
        id: json['id'],
        createTime: DateTime.tryParse(json['create_time'] ?? ''),
        name: json['name'],
        number: json['number'],
        status: json['status'],
        price: json['price'],
        userId: json['user_id'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'number': number,
        'status': status,
        'price': price,
        'user_id': userId,
      };

  TableModel copyWith({
    int? id,
    DateTime? createTime,
    String? name,
    int? number,
    int? status,
    int? price,
    String? userId,
  }) {
    return TableModel(
      id: id ?? this.id,
      createTime: createTime ?? this.createTime,
      name: name ?? this.name,
      number: number ?? this.number,
      status: status ?? this.status,
      price: price ?? this.price,
      userId: userId ?? this.userId,
    );
  }
}
