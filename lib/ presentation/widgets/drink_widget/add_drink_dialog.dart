import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/%20presentation/providers/drink/drink_viewmodel.dart';
import 'package:timerflow/config/constant/app_constant.dart';
import 'package:timerflow/domain/models/drink_model.dart';
import 'package:timerflow/utils/user/user_manager.dart';

class AddDrinkDialog extends StatefulWidget {
  const AddDrinkDialog({super.key});

  static Future<void> show(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => const Dialog(child: AddDrinkDialog()),
    );
  }

  @override
  State<AddDrinkDialog> createState() => _AddDrinkDialogState();
}

class _AddDrinkDialogState extends State<AddDrinkDialog> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final volumeController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DrinkViewModel>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: AppConstant.spacing,
          children: [
            Text('drink_add'.tr, style: TextStyle(fontSize: 18)),
            TextFormField(controller: nameController, decoration:  InputDecoration(labelText: 'title'.tr)),
            TextFormField(controller: priceController, decoration:  InputDecoration(labelText: 'price'.tr), keyboardType: TextInputType.number),
            TextFormField(controller: volumeController, decoration:  InputDecoration(labelText: 'size'.tr), keyboardType: TextInputType.number),
            TextFormField(controller: amountController, decoration:  InputDecoration(labelText: 'amount'.tr), keyboardType: TextInputType.number),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () async {
                final userId = UserManager.currentUserId;
                final model = DrinkModel(
                  name: nameController.text,
                  price: int.parse(priceController.text),
                  volume: double.parse(volumeController.text),
                  amount: int.parse(amountController.text),
                  userId: userId!,
                );
                await provider.addDrink(model);
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              },
              child:  Text('add'.tr),
            ),
          ],
        ),
      ),
    );
  }
}
