import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/%20presentation/providers/food_viewmodel.dart';
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
        title: const Text("Taomni o‘chirish"),
        content: Text("'${foodModel.name}' nomli taom o‘chirilsinmi?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Bekor qilish"),
          ),
          TextButton(
            onPressed: () async {
              final foodProvider = Provider.of<FoodViewModel>(context, listen: false);
              await foodProvider.deleteFood(foodModel.id!);
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            },
            child: const Text("Tasdiqlash"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
