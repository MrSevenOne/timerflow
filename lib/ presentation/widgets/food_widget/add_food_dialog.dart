import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/%20presentation/providers/food_viewmodel.dart';
import 'package:timerflow/config/constant/app_constant.dart';
import 'package:timerflow/domain/models/food_model.dart';

class AddFoodDialog extends StatefulWidget {
  const AddFoodDialog({super.key});

  static Future<void> show(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (_) => 
         AddFoodDialog(),
    );
  }

  @override
  State<AddFoodDialog> createState() => _AddFoodDialogState();
}

class _AddFoodDialogState extends State<AddFoodDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _saveFood() {
    if (_formKey.currentState!.validate()) {
      int price = int.parse(_priceController.text);
      int amount = int.parse(_amountController.text);
      final food =
          FoodModel(name: _nameController.text, price: price, amount: amount,);

      context.read<FoodViewModel>().addFood(food);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppConstant.padding),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: AppConstant.spacing,
          children: [
            const Text('Yangi taom qo‘shish',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nomi'),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Nomini kiriting' : null,
            ),
            TextFormField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Narxi'),
              keyboardType: TextInputType.number,
              validator: (value) =>
                  value == null || value.isEmpty ? 'Narxni kiriting' : null,
            ),
            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Soni'),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Sonini kiriting' : null,
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: _saveFood,
              child: const Text('Qo‘shish'),
            ),
          ],
        ),
      ),
    );
  }
}
