import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/%20presentation/providers/food/food_viewmodel.dart';
import 'package:timerflow/domain/models/food_model.dart';

class DeleteFoodDialog extends StatelessWidget {
  final FoodModel foodModel;

  const DeleteFoodDialog({super.key, required this.foodModel});

  static Future<void> show({
    required BuildContext context,
    required FoodModel foodModel,
  }) async {
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title:  Text("food_delete".tr),
        content: Text("'${foodModel.name}' ${'food_delete_want'.tr}"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child:  Text("cencal".tr),
          ),
          TextButton(
            onPressed: () async {
              final foodProvider = Provider.of<FoodViewModel>(context, listen: false);
              await foodProvider.deleteFood(foodModel.id!);
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            },
            child:  Text("confirmation".tr),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
