import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/%20presentation/providers/drink/drink_viewmodel.dart';
import 'package:timerflow/domain/models/drink_model.dart';

class EditDrinkDialog extends StatefulWidget {
  final DrinkModel drinkModel;
  const EditDrinkDialog({super.key, required this.drinkModel});

  static Future<void> show(BuildContext context, {required DrinkModel drinkModel}) async {
    await showDialog(
      context: context,
      builder: (_) => Dialog(child: EditDrinkDialog(drinkModel: drinkModel)),
    );
  }

  @override
  State<EditDrinkDialog> createState() => _EditDrinkDialogState();
}

class _EditDrinkDialogState extends State<EditDrinkDialog> {
  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController volumeController;
  late TextEditingController amountController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.drinkModel.name);
    priceController = TextEditingController(text: widget.drinkModel.price.toString());
    volumeController = TextEditingController(text: widget.drinkModel.volume.toString());
    amountController = TextEditingController(text: widget.drinkModel.amount.toString());
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DrinkViewModel>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('edit_drink'.tr, style: TextStyle(fontSize: 18)),
          TextField(controller: nameController, decoration:  InputDecoration(labelText: 'title'.tr)),
          TextField(controller: priceController, decoration:  InputDecoration(labelText: 'price'.tr), keyboardType: TextInputType.number),
          TextField(controller: volumeController, decoration:  InputDecoration(labelText: 'size'.tr), keyboardType: TextInputType.number),
          TextField(controller: amountController, decoration:  InputDecoration(labelText: 'amount'.tr), keyboardType: TextInputType.number),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () async {
              final updated = widget.drinkModel.copyWith(
                name: nameController.text,
                price: int.parse(priceController.text),
                volume: double.parse(volumeController.text),
                amount: int.parse(amountController.text),
              );
              await provider.updateDrink(updated);
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            },
            child:  Text('update'.tr),
          ),
        ],
      ),
    );
  }
}
