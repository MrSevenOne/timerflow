import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/%20presentation/providers/product_viewmodel.dart';
import 'package:timerflow/%20presentation/widgets/show_dialog/dialog_buttons.dart';
import 'package:timerflow/config/constant/app_constant.dart';
import 'package:timerflow/config/theme/ligth_theme.dart';
import 'package:timerflow/domain/models/products_model.dart';
import 'package:timerflow/utils/responsive_dialog.dart';

class EditProductDialog extends StatefulWidget {
  final ProductModel product;

  const EditProductDialog({super.key, required this.product});

  static Future<void> show({
    required BuildContext context,
    required ProductModel product,
  }) async {
    await showDialog(
      context: context,
      builder: (_) => ResponsiveDialog(
        child: EditProductDialog(product: product),
      ),
    );
  }

  @override
  State<EditProductDialog> createState() => _EditProductDialogState();
}

class _EditProductDialogState extends State<EditProductDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _amountController;
  late String _selectedType;

  final List<String> _types = ['drink', 'food'];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product.name);
    _priceController =
        TextEditingController(text: widget.product.price.toString());
    _amountController =
        TextEditingController(text: widget.product.amount.toString());
    _selectedType = widget.product.type;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final updated = widget.product.copyWith(
      name: _nameController.text.trim(),
      price: int.parse(_priceController.text),
      amount: int.parse(_amountController.text),
      type: _selectedType,
    );

    try {
      await context.read<ProductViewModel>().updateProduct(updated);
      if (mounted) Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Xatolik: $e")),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Mahsulotni tahrirlash",
            style: theme.textTheme.titleLarge!
                .copyWith(color: mainColor, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Nomi'),
            validator: (value) =>
                value == null || value.isEmpty ? 'Nomini kiriting' : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _priceController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Narxi (soʻm)'),
            validator: (value) =>
                value == null || int.tryParse(value) == null
                    ? 'Narxni kiriting'
                    : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Miqdori'),
            validator: (value) =>
                value == null || int.tryParse(value) == null
                    ? 'Miqdorini kiriting'
                    : null,
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: _selectedType,
            items: _types
                .map((type) => DropdownMenuItem(
                      value: type,
                      child: Text(type),
                    ))
                .toList(),
            onChanged: (value) {
              if (value != null) setState(() => _selectedType = value);
            },
            decoration: const InputDecoration(labelText: 'Turi'),
          ),
          const SizedBox(height: 20),
          DialogButtons(
            isLoading: _isLoading,
            onCancel: () => Navigator.pop(context),
            onSubmit: _submit,
          ),
        ],
      ),
    );
  }
}
