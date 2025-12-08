class TariffModel {
  final int? id;
  final DateTime? createdAt;
  final String name;
  final String price;
  final int tableCount;
  final int deadline;
  final bool getReport;
  final String? description;

  TariffModel({
    this.id,
    this.createdAt,
    required this.name,
    required this.price,
    required this.tableCount,
    required this.deadline,
    required this.getReport,
    this.description,
  });

  factory TariffModel.fromJson(Map<String, dynamic> json) {
    return TariffModel(
      id: json['id'] as int?,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      name: json['name'],
      price: json['price'],
      tableCount: json['table_count'],
      deadline: json['deadline'],
      getReport: json['get_report'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt?.toIso8601String(),
      'name': name,
      'price': price,
      'table_count': tableCount,
      'deadline': deadline,
      'get_report': getReport,
      'description': description,
    };
  }
}
