import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/%20presentation/providers/session/table_report_viewmodel.dart';
import 'package:timerflow/%20presentation/screens/reports/bar_report.dart';
import 'package:timerflow/%20presentation/widgets/table_widget/table_report_info.dart';
import 'package:timerflow/config/constant/app_constant.dart';

class TableReportPage extends StatefulWidget {
  const TableReportPage({super.key});

  @override
  _TableReportPageState createState() => _TableReportPageState();
}

class _TableReportPageState extends State<TableReportPage> {
  DateTimeRange? _selectedDateRange;

 @override
void initState() {
  super.initState();
  final viewModel = context.read<SessionReportViewModel>();
  
  WidgetsBinding.instance.addPostFrameCallback((_) {
    viewModel.fetchAllReports();
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("table_title".tr),
        actions: [
          IconButton(
            icon: Icon(Icons.date_range),
            onPressed: () async {
              final DateTimeRange? picked = await showDateRangePicker(
                context: context,
                firstDate: DateTime(2020),
                lastDate: DateTime(2101),
                initialDateRange: _selectedDateRange,
                builder: (context, child) {
                  return Theme(
                    data: ThemeData.light().copyWith(
                      primaryColor: Colors.blue,
                      buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
                    ),
                    child: child!,
                  );
                },
              );

              if (picked != null && picked != _selectedDateRange) {
                setState(() {
                  _selectedDateRange = picked;
                });
              }
            },
          ),
        ],
      ),
      body: TableReportBody(
        selectedDateRange: _selectedDateRange, // Pass the selected date range
      ),
    );
  }
}

class TableReportBody extends StatelessWidget {
  final DateTimeRange? selectedDateRange;

  const TableReportBody({super.key, this.selectedDateRange});

  @override
  Widget build(BuildContext context) {
    return Consumer<SessionReportViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (viewModel.error != null) {
          return Center(child: Text('Error: ${viewModel.error}'));
        }

        // Filter reports if a date range is selected
        final reports = selectedDateRange != null
            ? viewModel.sessionReports.where((report) {
                final reportDate = DateTime.parse(report.startTime.toString());
                return reportDate.isAfter(selectedDateRange!.start) &&
                    reportDate.isBefore(selectedDateRange!.end);
              }).toList()
            : viewModel.sessionReports;

             // ✅ Calculate total sum
        final int totalSumOrder = reports.fold<int>(0, (sum, report) {
          return sum + report.tablePrice;
        });

        if (reports.isEmpty) {
          return  Center(child: Text('report_nofount'.tr));
        }

        return Column(
          children: [
            // Displaying the filtered reports
            Expanded(
              child: ListView.builder(
                itemCount: reports.length,
                itemBuilder: (context, index) {
                  final report = reports[index];
                  return Card(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: AppConstant.padding,
                          horizontal: AppConstant.padding / 2),
                      child: Column(
                        children: [
                          Text(
                            report.tableModel!.name,
                            style: GoogleFonts.pridi(
                                textStyle: Theme.of(context).textTheme.titleLarge),
                          ),
                          SizedBox(height: 4.h),
                          TableReportInfoRow(
                              title: 'start_time'.tr,
                              value: report.formattedStartTime),
                          TableReportInfoRow(
                              title: 'end_time'.tr, value: report.formattedEndTime),
                              TableReportInfoRow(
                              title: 'duration'.tr, value: report.duration),
                          TableReportInfoRow(
                              title: 'table_price'.tr,
                              value: report.tableModel!.formattedPrice),
                          TableReportInfoRow(title: 'table_sum'.tr, value: report.formattedTablePrice),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            TotalSum(context, totalSumOrder),
          ],
        );
      },
    );
  }
}
