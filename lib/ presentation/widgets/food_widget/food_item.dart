import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:timerflow/%20presentation/widgets/food_widget/delete_food_dialog.dart';
import 'package:timerflow/%20presentation/widgets/food_widget/edit_food_dialog.dart';
import 'package:timerflow/domain/models/food_model.dart';

class FoodItem extends StatelessWidget {
  final FoodModel food;
  final VoidCallback onTap;

  const FoodItem({
    super.key,
    required this.food,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(food.id),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          IconButton(
            onPressed: ()=> DeleteFoodDialog.show(context: context, foodModel: food),
            icon: const Icon(Icons.delete, color: Colors.red),
          ),
          IconButton(onPressed: ()=> EditFoodDialog.show(context: context, food: food), icon: Icon(Icons.edit))
        ],
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: ListTile(
          title: Text(food.name),
          subtitle: Text('Kategoriya: ${food.amount} • Narxi: ${food.price} so‘m'),
          onTap: onTap,
        ),
      ),
    );
  }
}
