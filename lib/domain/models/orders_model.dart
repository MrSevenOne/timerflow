// Drinks Model
import 'package:timerflow/domain/models/drink_model.dart';
import 'package:timerflow/domain/models/food_model.dart';

class OrderDrinkModel {
  final int? id;
  final DateTime? createdAt;
  final int sessionId;
  final int drinkId;
  final int quantity;
  final DrinkModel? drinkModel; // Added DrinkModel as a field

  OrderDrinkModel({
    this.id,
    this.createdAt,
    required this.sessionId,
    required this.drinkId,
    required this.quantity,
    this.drinkModel,
  });

  // Convert from JSON
  factory OrderDrinkModel.fromJson(Map<String, dynamic> json) {
    return OrderDrinkModel(
      id: json['id'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      sessionId: json['session_id'],
      drinkId: json['drink_id'],
      quantity: json['quantity'],
      // Now properly initializing DrinkModel from JSON
      drinkModel:
          json['drink'] != null ? DrinkModel.fromJson(json['drink']) : null,
    );
  }

  get price => null;

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'session_id': sessionId,
      'drink_id': drinkId,
      'quantity': quantity,
    };
  }

  // Copy the object with optional new values
  OrderDrinkModel copyWith({
    int? id,
    DateTime? createdAt,
    int? sessionId,
    int? drinkId,
    int? quantity,
    int? totalPrice,
    DrinkModel? drinkModel,
  }) {
    return OrderDrinkModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      sessionId: sessionId ?? this.sessionId,
      drinkId: drinkId ?? this.drinkId,
      quantity: quantity ?? this.quantity,
      drinkModel: drinkModel ?? this.drinkModel,
    );
  }
}

// Order Food Model
class OrderFoodModel {
  final int? id;
  final DateTime? createdAt;
  final int sessionId;
  final int foodId;
  final int quantity;
  final FoodModel? foodModel;

  OrderFoodModel({
    this.id,
    this.createdAt,
    required this.sessionId,
    required this.foodId,
    required this.quantity,
    this.foodModel,
  });

  // Convert from JSON
  factory OrderFoodModel.fromJson(Map<String, dynamic> json) {
    return OrderFoodModel(
      id: json['id'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      sessionId: json['session_id'],
      foodId: json['food_id'],
      quantity: json['quantity'],
      foodModel: json['food'] != null ? FoodModel.fromJson(json['food']) : null,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'session_id': sessionId,
      'food_id': foodId,
      'quantity': quantity,
    };
  }

  // Copy the object with optional new values
  OrderFoodModel copyWith({
    int? id,
    DateTime? createdAt,
    int? sessionId,
    int? foodId,
    int? quantity,
    int? totalPrice,
  }) {
    return OrderFoodModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      sessionId: sessionId ?? this.sessionId,
      foodId: foodId ?? this.foodId,
      quantity: quantity ?? this.quantity,
    );
  }
}
