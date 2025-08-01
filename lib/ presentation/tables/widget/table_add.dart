import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timerflow/%20presentation/widgets/show_dialog/dialog_buttons.dart';
import 'package:timerflow/config/constant/app_constant.dart';
import 'package:timerflow/config/theme/ligth_theme.dart';
import 'package:timerflow/domain/models/table_model.dart';

class AddTableDialogWidget extends StatefulWidget {
  final void Function(TableModel table) onSubmit;

  const AddTableDialogWidget({super.key, required this.onSubmit});

  @override
  State<AddTableDialogWidget> createState() => _AddTableDialogWidgetState();
}

class _AddTableDialogWidgetState extends State<AddTableDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _typeController = TextEditingController();
  final _priceController = TextEditingController();

  bool _isLoading = false;

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final userId = Supabase.instance.client.auth.currentUser!.id;

      final table = TableModel(
        id: null,
        createdAt: DateTime.now(),
        updatedAt: null,
        userId: userId,
        name: _nameController.text.trim(),
        number: int.parse(_numberController.text),
        type: _typeController.text.trim(),
        pricePerHour: double.parse(_priceController.text),
        status: 'free',
      );

      widget.onSubmit(table);
      Navigator.pop(context);
    } catch (e) {
      // Error handling (optional)
      debugPrint('Error: $e');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Yangi stol qo‘shish',
        style: TextStyle(fontWeight: FontWeight.w600, color: mainColor),
        textAlign: TextAlign.center,
      ),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Stol nomi'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'To‘ldirilishi shart' : null,
              ),
               SizedBox(height: AppConstant.spacing),
              TextFormField(
                controller: _numberController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Raqami'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'To‘ldirilishi shart';
                  if (int.tryParse(value) == null) return 'Faqat son kiriting';
                  return null;
                },
              ),
               SizedBox(height: AppConstant.spacing),
              TextFormField(
                controller: _typeController,
                decoration: const InputDecoration(labelText: 'Turi'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'To‘ldirilishi shart';
                  if (value != 'billiard' && value != 'tennis') {
                    return 'Faqat "billiard" yoki "tennis" yozing';
                  }
                  return null;
                },
              ),
               SizedBox(height: AppConstant.spacing),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Soatlik narxi (uzs)'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'To‘ldirilishi shart';
                  if (double.tryParse(value) == null) return 'Faqat raqam kiriting';
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        DialogButtons(
          isLoading: _isLoading,
          onCancel: () => Navigator.pop(context),
          onSubmit: _submit,
          submitText: 'Qo‘shish',
        ),
      ],
    );
  }
}
