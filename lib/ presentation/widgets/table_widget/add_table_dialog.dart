import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/%20presentation/providers/auth/auth_viewmodel.dart';
import 'package:timerflow/%20presentation/providers/tables_viewmodel.dart';
import 'package:timerflow/config/constant/app_constant.dart';
import 'package:timerflow/domain/models/table_model.dart';

class AddTableDialog extends StatefulWidget {
  const AddTableDialog({super.key});

  static Future<void> show(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (_) => const Dialog(
        child: AddTableDialog(),
      ),
    );
  }

  @override
  State<AddTableDialog> createState() => _AddTableDialogState();
}

class _AddTableDialogState extends State<AddTableDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namerController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void dispose() {
    _namerController.dispose();
    _numberController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _saveTable() {
    final int number = int.parse(_numberController.text);
    final int price = int.parse(_priceController.text);
    final userId = context.read<AuthViewModel>().user?.id;

    if (_formKey.currentState!.validate()) {
      final table = TableModel(
        name: _namerController.text,
        number: number,
        status: 0,
        price: price,
        userId: userId!,
      );

      final viewModel = context.read<TableViewModel>();
      viewModel.addTable(table);

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: AppConstant.spacing,
          children: [
            const Text(
              'Yangi stol qo\'shish',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            TextFormField(
              controller: _namerController,
              decoration: const InputDecoration(labelText: 'Stol nomi'),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Nomni kiriting' : null,
            ),
            TextFormField(
              controller: _numberController,
              decoration: const InputDecoration(labelText: 'Stol raqami'),
              keyboardType: TextInputType.number,
              validator: (value) =>
                  value == null || value.isEmpty ? 'Raqam kiriting' : null,
            ),
            TextFormField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Narxi (soatiga)'),
              keyboardType: TextInputType.number,
              validator: (value) =>
                  value == null || value.isEmpty ? 'Narx kiriting' : null,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveTable,
              child: const Text('Saqlash'),
            ),
          ],
        ),
      ),
    );
  }
}
