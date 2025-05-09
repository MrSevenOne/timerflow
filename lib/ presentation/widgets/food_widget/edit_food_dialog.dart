import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/%20presentation/providers/food/food_viewmodel.dart';
import 'package:timerflow/domain/models/food_model.dart';

class EditFoodDialog extends StatefulWidget {
  final FoodModel food;

  const EditFoodDialog({super.key, required this.food});

  static Future<void> show({
    required BuildContext context,
    required FoodModel food,
  }) async {
    await showDialog(
      context: context,
      builder: (_) => EditFoodDialog(food: food),
    );
  }

  @override
  State<EditFoodDialog> createState() => _EditFoodDialogState();
}

class _EditFoodDialogState extends State<EditFoodDialog> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _amountController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.food.name);
    _priceController = TextEditingController(text: widget.food.price.toString());
    _amountController = TextEditingController(text: widget.food.amount.toString());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final foodProvider = Provider.of<FoodViewModel>(context, listen: false);

    return AlertDialog(
      title: const Text('Taomni tahrirlash'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nomi'),
              validator: (value) => value == null || value.isEmpty ? 'Nomini kiriting' : null,
            ),
            TextFormField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Narxi'),
              validator: (value) => value == null || value.isEmpty ? 'Narxini kiriting' : null,
            ),
            TextFormField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: 'Kategoriya'),
              validator: (value) => value == null || value.isEmpty ? 'Kategoriya kiriting' : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Bekor qilish"),
        ),
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              final updatedFood = widget.food.copyWith(
                name: _nameController.text.trim(),
                price: int.tryParse(_priceController.text.trim()) ?? widget.food.price,
                amount: int.tryParse(_amountController.text.trim()),
              );
              await foodProvider.updateFood(updatedFood);
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            }
          },
          child: const Text('Saqlash'),
        ),
      ],
    );
  }
}
