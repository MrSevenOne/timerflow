import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/%20presentation/providers/auth/auth_viewmodel.dart';
import 'package:timerflow/%20presentation/providers/drink/drink_viewmodel.dart';
import 'package:timerflow/domain/models/drink_model.dart';

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
    final userId = context.read<AuthViewModel>().user?.id;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Ichimlik qo‘shish', style: TextStyle(fontSize: 18)),
            TextFormField(controller: nameController, decoration: const InputDecoration(labelText: 'Nomi')),
            TextFormField(controller: priceController, decoration: const InputDecoration(labelText: 'Narxi'), keyboardType: TextInputType.number),
            TextFormField(controller: volumeController, decoration: const InputDecoration(labelText: 'Hajmi (ml)'), keyboardType: TextInputType.number),
            TextFormField(controller: amountController, decoration: const InputDecoration(labelText: 'Soni'), keyboardType: TextInputType.number),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () async {
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
              child: const Text('Qo‘shish'),
            ),
          ],
        ),
      ),
    );
  }
}
