

import 'package:timerflow/exports.dart';

class PaymentBottomSheet extends StatefulWidget {
  final int tableId;
  final int sessionReportId;
  final int sessionId;

  const PaymentBottomSheet({
    super.key,
    required this.tableId,
    required this.sessionReportId,
    required this.sessionId,
  });

  static Future<void> show({
    required BuildContext context,
    required int tableId,
    required int sessionReportId,
    required int sessionId,
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
        child: PaymentBottomSheet(
          tableId: tableId,
          sessionReportId: sessionReportId,
          sessionId: sessionId,
        ),
      ),
    );
  }

  @override
  State<PaymentBottomSheet> createState() => _PaymentBottomSheetState();
}

class _PaymentBottomSheetState extends State<PaymentBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _paymentType = 'cash'.tr;
  final List<String> _paymentOptions = ['cash'.tr, 'click'.tr];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final orderViewModel = Provider.of<OrderViewModel>(context, listen: false);
      await orderViewModel.fetchDrinkOrdersBySessionId(widget.sessionId);
      await orderViewModel.fetchFoodOrdersBySessionId(widget.sessionId);
    });
  }

  Future<void> _handleCheckout(BuildContext context) async {
  final orderViewModel = context.read<OrderViewModel>();
  final sessionViewModel = context.read<SessionViewModel>();
  final drinkReportViewModel = context.read<DrinkReportViewModel>();
  final foodReportViewModel = context.read<FoodReportViewModel>();
  final tableViewModel = context.read<TableViewModel>();
  final checkoutViewModel = context.read<CheckoutViewModel>();

  final userId = UserManager.currentUserId!;
  final orderSum = orderViewModel.totalOrderPrice;
  final tableSum = sessionViewModel.tablePrice;

  if (_formKey.currentState!.validate()) {
    final paymentSum = int.tryParse(_amountController.text.trim()) ?? 0;
    final paymentType = _paymentType == 'cash'.tr ? 1 : 2;
    final description = _descriptionController.text.trim();

    final paymentModel = PaymentReportModel(
      paymentSum: paymentSum,
      paymentType: paymentType,
      orderSum: orderSum,
      tableSum: tableSum,
      totalSum: orderSum + tableSum,
      sessionReportId: widget.sessionReportId,
      description: description,
      createTime: DateTime.now(),
      userId: userId,
      tableId: widget.tableId,
    );

    final isSuccess = await checkoutViewModel.checkoutAll(
      payment: paymentModel,
      insertDrinkReports: () => drinkReportViewModel.insertBulkBySession(
        sessionId: widget.sessionId,
        sessionReportId: widget.sessionReportId,
      ),
      insertFoodReports: () => foodReportViewModel.insertBulkBySession(
        sessionId: widget.sessionId,
        sessionReportId: widget.sessionReportId,
      ),
      deleteSession: () => sessionViewModel.deleteSession(widget.sessionId),
      freeTable: () => tableViewModel.updateStatus(widget.tableId, 0),
    );

    if (!context.mounted) return;

    if (isSuccess) {
      Navigator.pop(context); // close bottom sheet
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(checkoutViewModel.error ?? 'Xatolik yuz berdi')),
      );
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Consumer<CheckoutViewModel>(
      builder: (context, checkoutProvider, _) {
        return Padding(
          padding: EdgeInsets.all(AppConstant.padding),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("payment_title".tr,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: AppConstant.spacing),
                TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'paymenting_sum'.tr),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'input_sum'.tr : null,
                ),
                SizedBox(height: AppConstant.spacing),
                DropdownButtonFormField<String>(
                  value: _paymentType,
                  decoration: InputDecoration(labelText: 'payment_type'.tr),
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
                  decoration: InputDecoration(labelText: 'description'.tr),
                  maxLines: 2,
                ),
                SizedBox(height: AppConstant.spacing * 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("cencal".tr),
                    ),
                    ElevatedButton(
                      onPressed: checkoutProvider.isLoading
                          ? null
                          : () async => await _handleCheckout(context),
                      child: checkoutProvider.isLoading
                          ? const CircularProgressIndicator()
                          : Text("confirmation".tr),
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
