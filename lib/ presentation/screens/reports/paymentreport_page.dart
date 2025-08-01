import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/%20presentation/providers/payment_report_provider.dart';
import 'package:timerflow/utils/formatter/date_formatter.dart';
import 'package:timerflow/utils/responsive_wrap.dart';

class PaymentReportPage extends StatelessWidget {
  const PaymentReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final reportVM = context.read<PaymentReportViewModel>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      reportVM.fetchPayments();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Toʻlov"),
        actions: [
          PopupMenuButton<ReportFilter>(
            onSelected: (filter) {
              context.read<PaymentReportViewModel>().applyFilter(filter);
            },
            icon: Image.asset('assets/icons/report.png', height: 32, width: 32),
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: ReportFilter.daily,
                child: Text("Bugungi"),
              ),
              PopupMenuItem(
                value: ReportFilter.weekly,
                child: Text("Haftalik"),
              ),
              PopupMenuItem(
                value: ReportFilter.monthly,
                child: Text("Oylik"),
              ),
            ],
          ),
        ],
      ),
      body: const PaymentReportBody(),
      bottomNavigationBar: Consumer<PaymentReportViewModel>(
        builder: (context, viewModel, _) {
          return Container(
            color: Colors.black12,
            padding: const EdgeInsets.all(16),
            child: Text(
              "Umumiy summa: ${viewModel.totalAmount} soʻm",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          );
        },
      ),
    );
  }
}

class PaymentReportBody extends StatelessWidget {
  const PaymentReportBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentReportViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (viewModel.payments.isEmpty) {
          return const Center(child: Text("Toʻlovlar mavjud emas"));
        }

        return ResponsiveWrap(
          spacing: 16,
          children: viewModel.payments.map((report) {
            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _reportRow("Toʻlov vaqti",
                        DateFormatter.formatTime(time: report.paymentTime!)),
                    const SizedBox(height: 8),
                    _reportRow(
                        "Stol narxi", '${report.totaltableTimeAmount} soʻm'),
                    _reportRow("Bar mahsulotlar",
                        '${report.totalproductsAmount} soʻm'),
                    const Divider(),
                    _reportRow("Jami", '${report.totalAmount} soʻm'),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _reportRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$title:",
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
