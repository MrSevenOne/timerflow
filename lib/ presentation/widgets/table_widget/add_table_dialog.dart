import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/%20presentation/providers/table/tables_viewmodel.dart';
import 'package:timerflow/config/constant/app_constant.dart';
import 'package:timerflow/domain/models/table_model.dart';
import 'package:timerflow/utils/user/user_manager.dart';

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
    final userId = UserManager.currentUserId;

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
      padding:  EdgeInsets.symmetric(horizontal:  AppConstant.padding,vertical: AppConstant.padding*1.5),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: AppConstant.spacing/2,
          children: [
             Text(
              'add_table'.tr,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            TextFormField(
              controller: _namerController,
              decoration:  InputDecoration(labelText: 'table_name'.tr),
              validator: (value) =>
                  value == null || value.isEmpty ? 'input_name'.tr : null,
            ),
            TextFormField(
              controller: _numberController,
              decoration:  InputDecoration(labelText: 'table_number'.tr),
              keyboardType: TextInputType.number,
              validator: (value) =>
                  value == null || value.isEmpty ? 'input_table_number'.tr : null,
            ),
            TextFormField(
              controller: _priceController,
              decoration:  InputDecoration(labelText: 'table_price'.tr),
              keyboardType: TextInputType.number,
              validator: (value) =>
                  value == null || value.isEmpty ? 'input_table_price'.tr : null,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveTable,
                child:  Text('save'.tr),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
