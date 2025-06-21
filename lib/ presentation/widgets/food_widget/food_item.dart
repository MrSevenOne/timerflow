import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_fonts/google_fonts.dart';
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
    final theme = Theme.of(context);
    return Slidable(
      key: ValueKey(food.id),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          IconButton(
            onPressed: () =>
                DeleteFoodDialog.show(context: context, foodModel: food),
            icon: const Icon(Icons.delete, color: Colors.red),
          ),
          IconButton(
              onPressed: () =>
                  EditFoodDialog.show(context: context, food: food),
              icon: Icon(Icons.edit))
        ],
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: ListTile(
          title: Text(food.name,style: GoogleFonts.pridi(textStyle: theme.textTheme.titleLarge)),
          subtitle: Text('${'price'.tr}: ${food.price} so‘m',style: theme.textTheme.labelMedium,),
          trailing: Text("${'amount'.tr}: ${food.amount}",style: theme.textTheme.labelMedium,),
          onTap: onTap,
        ),
      ),
    );
  }
}
