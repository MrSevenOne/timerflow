class FoodReportModel {
  final int? id;
  final DateTime? createdAt;
  final int foodId;
  final int price;
  final int amount;
  final int sessionReportId;

  FoodReportModel({
    this.id,
     this.createdAt,
    required this.foodId,
    required this.price,
    required this.amount,
    required this.sessionReportId,
  });

  factory FoodReportModel.fromJson(Map<String, dynamic> json) {
    return FoodReportModel(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      foodId: json['food_id'],
      price: json['price'],
      amount: json['amount'],
      sessionReportId: json['session_report_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'food_id': foodId,
      'price': price,
      'amount': amount,
      'session_report_id': sessionReportId,
    };
  }
}
