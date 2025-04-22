import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/%20presentation/providers/drink_viewmodel.dart';
import 'package:timerflow/domain/models/drink_model.dart';

class DeleteDrinkDialog extends StatelessWidget {
  final DrinkModel drinkModel;
  const DeleteDrinkDialog({super.key, required this.drinkModel});

  static Future<void> show(BuildContext context, {required DrinkModel drinkModel}) async {
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Ichimlikni o‘chirish"),
        content: Text('${drinkModel.name} nomli ichimlik o‘chirilsinmi?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Bekor qilish"),
          ),
          TextButton(
            onPressed: () async {
              final provider = Provider.of<DrinkViewModel>(context, listen: false);
              await provider.deleteDrink(drinkModel.id!);
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            },
            child: const Text('Tasdiqlash'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
