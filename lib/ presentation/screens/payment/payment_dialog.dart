import 'package:timerflow/%20presentation/providers/checkout_viewmodel.dart';
import 'package:timerflow/%20presentation/providers/order_viewmodel.dart';
import 'package:timerflow/exports.dart';

class PaymentDialog extends StatefulWidget {
  final TableModel table;
  final TableReportModel report;

  const PaymentDialog({
    super.key,
    required this.table,
    required this.report,
  });

  static Future<void> show(
    BuildContext context,
    TableModel table,
    TableReportModel report,
  ) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => PaymentDialog(table: table, report: report),
    );
  }

  @override
  State<PaymentDialog> createState() => _PaymentDialogState();
}

class _PaymentDialogState extends State<PaymentDialog> {
  final TextEditingController _amountController = TextEditingController();
  String? _errorText;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final checkoutVM = context.watch<CheckoutViewModel>();
    final orderVM = context.watch<OrderViewModel>();

    final totalAmount = orderVM.calculateTotalAmountForTable(
      widget.table.id ?? '',
      widget.table.priceSoFar,
    );

    return AlertDialog(
      title: const Text('To‘lovni tasdiqlash'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Stol: ${widget.table.name}\n'
            'Umumiy soat: ${widget.report.totalHours.toStringAsFixed(2)}\n'
            'Stol narxi: ${widget.report.tableRevenue.toStringAsFixed(0)}\n'
            'Jami miqdor: ${totalAmount.toStringAsFixed(0)} so‘m',
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'To‘lov summasi',
              errorText: _errorText,
              border: const OutlineInputBorder(),
            ),
          ),
          if (checkoutVM.isLoading)
            const Padding(
              padding: EdgeInsets.only(top: 12),
              child: CircularProgressIndicator(),
            ),
          if (checkoutVM.errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                checkoutVM.errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Bekor qilish"),
        ),
        TextButton(
          onPressed: () async {
            final input = _amountController.text.trim();
            final amount = double.tryParse(input);

            if (input.isEmpty || amount == null || amount <= 0) {
              setState(() {
                _errorText = "To‘g‘ri summani kiriting";
              });
              return;
            }

            await checkoutVM.completeCheckout(
              table: widget.table,
              report: widget.report,
              totalAmount: amount,
            );

            if (checkoutVM.errorMessage == null && mounted) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text("To‘lov muvaffaqiyatli tugatildi")),
              );
            }

            await context.read<TableProvider>().getTables();
          },
          child: const Text(
            "Tugatish",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
