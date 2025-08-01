import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/%20presentation/providers/product_report_viewmodel.dart';
import 'package:timerflow/utils/formatter/date_formatter.dart';
import 'package:timerflow/utils/formatter/number_formatted.dart';
import 'package:timerflow/utils/responsive_wrap.dart';

class BarReportPage extends StatelessWidget {
  const BarReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final reportVM = context.read<ProductReportViewModel>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      reportVM.fetchReports();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Bar Hisobot"),
        actions: [
          PopupMenuButton<ReportFilter>(
            onSelected: (filter) {
              context.read<ProductReportViewModel>().applyFilter(filter);
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
      body: const BarReportBody(),
      floatingActionButton: Consumer<ProductReportViewModel>(
  builder: (context, viewModel, _) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.black12,
      padding: const EdgeInsets.all(16),
      child: Text(
        "Umumiy summa: ${NumberFormatter.price(viewModel.totalAmount)} soʻm",
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  },
),

    );
  }
}

class BarReportBody extends StatelessWidget {
  const BarReportBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductReportViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (viewModel.reports.isEmpty) {
          return const Center(child: Text("Hisobotlar mavjud emas"));
        }

        return ResponsiveWrap(
          spacing: 16,
          children: viewModel.reports.map((report) {
            final product = report.product;

            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product?.name ?? "Nomaʼlum mahsulot",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _reportRow("Stol", report.tableModel?.name ?? "Nomaʼlum"),
                    _reportRow("Narxi",
                        "${NumberFormatter.price(product?.price ?? 0)} soʻm"),
                    _reportRow("Miqdori", "${report.quantity} dona"),
                    _reportRow("Buyurtma vaqti",
                        DateFormatter.formatWithMonth(date: report.createdAt)),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
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
      ),
    );
  }
}
