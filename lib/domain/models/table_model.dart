class TableModel {
  final int? id;
  final DateTime? createTime;
  final String name;
  final int number;
  final String status;
  final int price;

  TableModel({
     this.id,
     this.createTime,
    required this.name,
    required this.number,
    required this.status,
    required this.price,
  });

  factory TableModel.fromJson(Map<String, dynamic> json) => TableModel(
        id: json['id'],
        createTime: DateTime.tryParse(json['create_time'] ?? ''),
        name: json['name'],
        number: json['number'],
        status: json['status'],
        price: json['price'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'number': number,
        'status': status,
        'price': price,
      };

  TableModel copyWith({
    int? id,
    DateTime? createTime,
    String? name,
    int? number,
    String? status,
    int? price,
  }) {
    return TableModel(
      id: id ?? this.id,
      createTime: createTime ?? this.createTime,
      name: name ?? this.name,
      number: number ?? this.number,
      status: status ?? this.status,
      price: price ?? this.price,
    );
  }
}
