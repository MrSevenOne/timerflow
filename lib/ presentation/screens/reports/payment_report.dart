import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/%20presentation/providers/payment_viewmodel.dart';
import 'package:timerflow/%20presentation/screens/reports/bar_report.dart';
import 'package:timerflow/%20presentation/widgets/table_widget/table_report_info.dart';
import 'package:timerflow/config/constant/app_constant.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentReport extends StatefulWidget {
  const PaymentReport({super.key});

  @override
  State<PaymentReport> createState() => _PaymentReportState();
}

class _PaymentReportState extends State<PaymentReport> {
  DateTimeRange? _selectedDateRange;

  @override
  void initState() {
    super.initState();
    final viewModel = context.read<PaymentViewModel>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.fetchPayments();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('payment_title'.tr),
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
                      buttonTheme: ButtonThemeData(
                          textTheme: ButtonTextTheme.primary),
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
      body: PaymentReportBody(selectedDateRange: _selectedDateRange),
    );
  }
}

class PaymentReportBody extends StatelessWidget {
  final DateTimeRange? selectedDateRange;

  const PaymentReportBody({super.key, this.selectedDateRange});

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (viewModel.error != null) {
          return Center(child: Text('Error: ${viewModel.error}'));
        }

        final payments = selectedDateRange != null
            ? viewModel.payments.where((payment) {
                final date = DateTime.parse(payment.createTime.toString());
                return date.isAfter(selectedDateRange!.start) &&
                    date.isBefore(selectedDateRange!.end);
              }).toList()
            : viewModel.payments;

        final int totalSum = payments.fold<int>(
            0, (sum, payment) => sum + payment.paymentSum);

        if (payments.isEmpty) {
          return const Center(child: Text('No payments found.'));
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: payments.length,
                itemBuilder: (context, index) {
                  final payment = payments[index];
                  return Card(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: AppConstant.padding,
                        horizontal: AppConstant.padding / 2,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${payment.tableModel?.name} ${payment.tableModel?.number}',
                            style: GoogleFonts.pridi(
                                textStyle: Theme.of(context).textTheme.titleLarge),
                          ),
                          SizedBox(height: 4),
                         TableReportInfoRow(title: 'bar_sum'.tr, value: payment.OrderPrice),
                         TableReportInfoRow(title: 'table_sum'.tr, value: payment.TablePrice),
                         TableReportInfoRow(title: 'total_sum'.tr, value: payment.TotalPrice),
                         TableReportInfoRow(title: 'payment_sum'.tr, value: payment.PaymentPrice),
                         TableReportInfoRow(title: 'payment_type'.tr, value: payment.PaymentType),
                         TableReportInfoRow(title: "payment_time".tr, value: payment.PaymentTime),
                         TableReportInfoRow(title: 'description'.tr, value: payment.description ?? ''),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
           TotalSum(context,totalSum),
          ],
        );
      },
    );
  }
}
