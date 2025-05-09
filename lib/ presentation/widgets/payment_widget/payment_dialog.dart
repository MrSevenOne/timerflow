import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/%20presentation/providers/drink/drink_report_viewmodel.dart';
import 'package:timerflow/%20presentation/providers/food/food_report_viewmodel.dart';
import 'package:timerflow/%20presentation/providers/order/order_viewmodel.dart';
import 'package:timerflow/%20presentation/providers/payment_viewmodel.dart';
import 'package:timerflow/%20presentation/providers/session/session_report_viewmodel.dart';
import 'package:timerflow/%20presentation/providers/session/session_viewmodel.dart';
import 'package:timerflow/%20presentation/providers/tables_viewmodel.dart';
import 'package:timerflow/config/constant/app_constant.dart';
import 'package:timerflow/domain/models/payment_model.dart';

// ignore: must_be_immutable
class PaymentBottomSheet extends StatefulWidget {
  int tableId;
  PaymentBottomSheet({
    super.key,
    required this.tableId,
  });

  static Future<void> show({
    required BuildContext context,
    required int tableId,
  }) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: PaymentBottomSheet(tableId: tableId),
      ),
    );
  }

  @override
  State<PaymentBottomSheet> createState() => _PaymentBottomSheetState();
}

class _PaymentBottomSheetState extends State<PaymentBottomSheet> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final sessionViewModel =
          Provider.of<SessionViewModel>(context, listen: false);
      final orderViewModel =
          Provider.of<OrderViewModel>(context, listen: false);
      final sessionReportProvider =
          Provider.of<SessionReportViewModel>(context, listen: false);

      final sessionId = sessionViewModel.session?.id;
      await sessionReportProvider.getSessionReportBySessionId(sessionId!);
      await orderViewModel.fetchDrinkOrdersBySessionId(sessionId);
      await orderViewModel.fetchFoodOrdersBySessionId(sessionId);
    });
  }

  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _paymentType = 'Naqt';
  final List<String> _paymentOptions = ['Naqt', 'Click'];
// Payment function
  Future<void> _handlePayment(BuildContext context) async {
    final orderViewModel = context.read<OrderViewModel>();
    final sessionViewModel = context.read<SessionViewModel>();
    final sessionReportViewModel = context.read<SessionReportViewModel>();
    final drinkReportViewModel = context.read<DrinkReportViewModel>();
    final foodReportViewModel = context.read<FoodReportViewModel>();
    final tableViewmodel = context.read<TableViewModel>();
    final sessionId = sessionViewModel.session?.id;

    final orderSum = orderViewModel.totalOrderPrice;
    final tableSum = sessionViewModel.tablePrice;
    final sessionReportId = sessionReportViewModel.sessionbyId!.id!;

    if (_formKey.currentState!.validate()) {
      final paymentSum = int.tryParse(_amountController.text.trim()) ?? 0;
      final paymentType = _paymentType == 'Naqt' ? 1 : 2;
      final description = _descriptionController.text.trim();

      final paymentModel = PaymentReportModel(
        paymentSum: paymentSum,
        paymentType: paymentType,
        orderSum: orderSum,
        tableSum: tableSum,
        totalSum: orderSum + tableSum,
        sessionReportId: sessionReportId,
        description: description,
        createTime: DateTime.now(),
      );
      debugPrint("sessionReport id; $sessionReportId");
      final provider = Provider.of<PaymentViewModel>(context, listen: false);

      // Call insertBulkBySession after payment is added
      await drinkReportViewModel.insertBulkBySession(
        sessionId: sessionId!,
        sessionReportId: sessionReportId,
      );
      await foodReportViewModel.insertBulkBySession(
        sessionId: sessionId,
        sessionReportId: sessionReportId,
      );
      await sessionViewModel.deleteSession(sessionId);
      await tableViewmodel.updateStatus(widget.tableId, 0);
      //payment
      await provider.addPayment(paymentModel);

      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [TextButton(onPressed: () {}, child: Text("ok"))],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentViewModel>(
      builder: (context, paymentProvider, _) {
        return Padding(
          padding: EdgeInsets.all(AppConstant.padding),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("To‘lov",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: AppConstant.spacing),
                TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration:
                      const InputDecoration(labelText: 'To‘lov miqdori'),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Miqdor kiriting' : null,
                ),
                SizedBox(height: AppConstant.spacing),
                DropdownButtonFormField<String>(
                  value: _paymentType,
                  decoration: const InputDecoration(labelText: 'To‘lov turi'),
                  items: _paymentOptions.map((type) {
                    return DropdownMenuItem(value: type, child: Text(type));
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _paymentType = value);
                    }
                  },
                ),
                SizedBox(height: AppConstant.spacing),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Izoh'),
                  maxLines: 2,
                ),
                SizedBox(height: AppConstant.spacing * 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Bekor qilish"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await _handlePayment(context);
                      },
                      child: paymentProvider.isLoading == true
                          ? Text('loading')
                          : Text("Tastiqlash"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
