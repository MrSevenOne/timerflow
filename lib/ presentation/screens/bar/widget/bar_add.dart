// 📁 lib/presentation/screens/bar/widget/bar_add_dialog.dart
import 'package:timerflow/%20presentation/widgets/show_dialog/dialog_buttons.dart';
import 'package:timerflow/exports.dart';
import 'package:timerflow/utils/responsive_dialog.dart';

class BarAddDialog extends StatefulWidget {
  const BarAddDialog({super.key});

  static Future<void> show(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (_) => const ResponsiveDialog(
        child: BarAddDialog(),
      ),
    );
  }

  @override
  State<BarAddDialog> createState() => _BarAddDialogState();
}

class _BarAddDialogState extends State<BarAddDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _amountController = TextEditingController();
  String _selectedType = 'drink';

  final List<String> _types = ['drink', 'food'];
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);
    final userId = Supabase.instance.client.auth.currentUser?.id;

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Foydalanuvchi aniqlanmadi')),
      );
      setState(() => _isSubmitting = false);
      return;
    }

    final newProduct = ProductModel(
      userId: userId,
      name: _nameController.text.trim(),
      price: int.parse(_priceController.text),
      type: _selectedType,
      amount: int.parse(_amountController.text),
    );

    try {
      await context.read<ProductViewModel>().addProduct(newProduct);
      if (mounted) Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Xatolik: $e")),
      );
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
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
            "Mahsulot qo'shish",
            style: theme.textTheme.titleLarge!.copyWith(
              color: mainColor,
              fontWeight: FontWeight.w600,
            ),
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
          // SizedBox(
          //   width: double.infinity,
          //   child: ElevatedButton(
          //     onPressed: _isSubmitting ? null : _submit,
          //     style: ElevatedButton.styleFrom(backgroundColor: mainColor),
          //     child: _isSubmitting
          //         ? const SizedBox(
          //             width: 22,
          //             height: 22,
          //             child: CircularProgressIndicator(
          //               color: Colors.white,
          //               strokeWidth: 2,
          //             ),
          //           )
          //         : const Text("Qo'shish"),
          //   ),
          // ),
           DialogButtons(
          isLoading: _isSubmitting,
          onCancel: () => Navigator.pop(context),
          onSubmit: _submit,
          submitText: 'Qo‘shish',
        ),
        ],
      ),
    );
  }
}
