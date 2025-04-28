import 'package:timerflow/domain/models/drink_model.dart';
import 'package:timerflow/domain/models/food_model.dart';

class BarModel {
  int? id;
  DrinkModel drink;
  FoodModel food;
  BarModel({this.id, required this.drink, required this.food});
  
 factory BarModel.fromJson(Map<String, dynamic> json) {
    return BarModel(
      id: json['id'],
      drink: DrinkModel.fromJson(json['drinks']),
      food: FoodModel.fromJson(json['foods']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'drink': drink,
      'food': food,
    };
  }
}
