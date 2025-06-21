import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/%20presentation/providers/food/food_viewmodel.dart';
import 'package:timerflow/config/constant/app_constant.dart';
import 'package:timerflow/domain/models/food_model.dart';
import 'package:timerflow/utils/user/user_manager.dart';

class AddFoodDialog extends StatefulWidget {
  const AddFoodDialog({super.key});

  static Future<void> show(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (cotext) => AddFoodDialog(),
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
  final userId = UserManager.currentUserId;

  void _saveFood() {
    if (_formKey.currentState!.validate()) {
      int price = int.parse(_priceController.text);
      int amount = int.parse(_amountController.text);
      final food = FoodModel(
        name: _nameController.text,
        price: price,
        amount: amount,
        userId: userId!,
      );

      context.read<FoodViewModel>().addFood(food);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(AppConstant.padding),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
             Text('food_add'.tr,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 12),
            TextFormField(
              controller: _nameController,
              decoration:  InputDecoration(labelText: 'title'.tr),
              validator: (value) =>
                  value == null || value.isEmpty ? 'input_title'.tr : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _priceController,
              decoration:  InputDecoration(labelText: 'price'.tr),
              keyboardType: TextInputType.number,
              validator: (value) =>
                  value == null || value.isEmpty ? 'input_price'.tr : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration:  InputDecoration(labelText: 'amount'.tr),
              validator: (value) =>
                  value == null || value.isEmpty ? 'amount_input'.tr : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _saveFood,
          child:  Text('add'.tr),
        ),
      ],
    );
  }
}
