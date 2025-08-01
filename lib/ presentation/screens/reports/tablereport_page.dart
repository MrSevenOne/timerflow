import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/%20presentation/providers/table_report_provider.dart';
import 'package:timerflow/domain/models/table_report_model.dart';
import 'package:timerflow/utils/responsive_wrap.dart';

class TableReportPage extends StatefulWidget {
  const TableReportPage({super.key});

  @override
  State<TableReportPage> createState() => _TableReportPageState();
}

class _TableReportPageState extends State<TableReportPage> {
  @override
  void initState() {
    super.initState();
    context.read<TableReportViewModel>().fetchReports();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stol hisobotlari"),
        actions: [
          PopupMenuButton<ReportFilter>(
            onSelected: (filter) {
              context.read<TableReportViewModel>().applyFilter(filter);
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
      body: Consumer<TableReportViewModel>(
        builder: (context, reportVM, child) {
          if (reportVM.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (reportVM.error != null) {
            return Center(child: Text("Xatolik: ${reportVM.error}"));
          }

          final reports = reportVM.reports;

          if (reports.isEmpty) {
            return const Center(child: Text("Hisobotlar mavjud emas"));
          }

          return ResponsiveWrap(
            spacing: 16,
            children: reports.map((report) => _buildReportCard(report)).toList(),
          );
        },
      ),
      bottomNavigationBar: Consumer<TableReportViewModel>(
        builder: (context, reportVM, _) {
          return Container(
            color: Colors.black12,
            padding: const EdgeInsets.all(16),
            child: Text(
              "Jami tushum: ${reportVM.totalRevenue.toInt()} so'm",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          );
        },
      ),
    );
  }

  Widget _buildReportCard(TableReportModel report) {
    final table = report.table!;
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              table.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8.0),
            _cardItem('Stol raqami', table.number.toString()),
            _cardItem('Soatlik narxi', '${table.formattedPricePerHour} so‘m'),
            _cardItem('Boshlanish', report.formattedStartTime),
            _cardItem('Tugash', report.formattedEndTime),
            _cardItem('Davomiyligi', report.formattedDuration),
            const Divider(),
            _cardItem('Stol narxi', '${report.tableRevenue?.toInt() ?? 0} so‘m'),
          ],
        ),
      ),
    );
  }

  Widget _cardItem(String title, String subtitle) {
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
            subtitle,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
