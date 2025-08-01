import 'package:timerflow/%20presentation/providers/order_viewmodel.dart';
import 'package:timerflow/%20presentation/providers/payment_provider.dart';
import 'package:timerflow/%20presentation/providers/product_report_viewmodel.dart';
import 'package:timerflow/%20presentation/providers/table_report_provider.dart';
import 'package:timerflow/exports.dart';

class CheckoutViewModel with ChangeNotifier {
  final TableReportViewModel tableReportVM;
  final PaymentViewModel paymentVM;
  final TableProvider tableProvider;
  final ProductReportViewModel productReportViewModel;
  final OrderViewModel orderViewModel;

  bool isLoading = false;
  String? errorMessage;

  CheckoutViewModel({
    required this.tableReportVM,
    required this.paymentVM,
    required this.tableProvider,
    required this.productReportViewModel,
    required this.orderViewModel,
  });

  Future<void> completeCheckout({
    required TableModel table,
    required TableReportModel report,
    required double totalAmount,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final userId = UserManager.currentUserId!;
      final now = DateTime.now();

      /// Step 1: Hisobotni qo‘shish va ID olish
      final addedReport = await tableReportVM.addReport(report);

      if (addedReport == null || addedReport.id == null) {
        debugPrint("Hisobot ID olinmadi");
        throw Exception("Hisobot ID olinmadi");
      }

      /// ✅ Step 2: productsAmount hisoblash
      await orderViewModel.fetchOrdersByTableId(table.id!);
final productsAmount = orderViewModel.calculateTotalAmountForTable(table.id!);


      /// Step 3: Payment model yaratish va yozish
      final payment = PaymentModel(
        userId: userId,
        tableTimeAmount: report.tableRevenue,
        productsAmount: productsAmount,
        totalAmount: totalAmount,
        createdAt: now,
        paymentTime: now,
        tableReportId: addedReport.id,
      );

      /// Step 4: Buyurtmalarni reportga ko‘chirish
      await productReportViewModel.moveOrdersByTableId(table.id!);

      /// Step 5: To‘lovni yozish
      await paymentVM.addPayment(payment);

      /// Step 6: Stolni bo‘sh qilish
      await tableProvider.endTable(tableId: table.id!);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
