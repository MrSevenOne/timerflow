class TableModel {
  final int? id;
  final DateTime? createdAt;
  final String name;
  final String status;
  // ignore: non_constant_identifier_names
  final double rate_per_hour;
  final int number;


  TableModel({
    this.id,
    this.createdAt,
    required this.name,
    required this.status,
    // ignore: non_constant_identifier_names
    required this.rate_per_hour,
    required this.number,
  });

 factory TableModel.fromJson(Map<String, dynamic> json) {
  return TableModel(
    id: json['id'] as int?,
    createdAt: json['created_at'] != null
        ? DateTime.parse(json['created_at'])
        : null,
    name: json['name'] ?? '',
    status: json['status'] ?? '',
    rate_per_hour: json['rate_per_hour'] != null
        ? (json['rate_per_hour'] as num).toDouble()
        : 0.0,
    number: json['number'] != null ? json['number'] as int : 0,
  );
}


  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'status': status,
      'rate_per_hour': rate_per_hour,
      'number': number,
    };
  }
}
