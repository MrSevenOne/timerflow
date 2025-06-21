import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/%20presentation/providers/session/table_report_viewmodel.dart';
import 'package:timerflow/%20presentation/widgets/session_widget/session_info.dart';
import 'package:timerflow/config/constant/app_constant.dart';

// ignore: must_be_immutable
class PaymentPage extends StatefulWidget {
  int sessionId;
  PaymentPage({super.key, required this.sessionId});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Ensure that the report is fetched
      await Provider.of<SessionReportViewModel>(context, listen: false)
          .getSessionReportBySessionId(widget.sessionId);
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(widget.sessionId.toString());
    return Consumer<SessionReportViewModel>(
      builder: (context, sessionReportViewModel, child) {
        final report = sessionReportViewModel.sessionbyId;

        // Show a loading indicator while data is being fetched
        if (report == null) {
          return Scaffold(
            appBar: AppBar(
              title: Text("payment_title".tr),
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // Display session info once the report is available
        return Scaffold(
          appBar: AppBar(
            title: Text("payment_title".tr),
          ),
          body: Padding(
            padding: EdgeInsets.all(AppConstant.padding),
            child: Column(
              children: [
              
                    SessionInfoRow(
                    title: 'duration'.tr, value: report.duration),
                    SessionInfoRow(
                    title: 'table_price'.tr, value: '${report.tableId}'),
                    SessionInfoRow(
                    title: 'order_price'.tr, value: '${report.orderPrice}'),
                    SessionInfoRow(
                    title: 'total_sum'.tr, value: '${report.orderPrice+ report.tablePrice}')
                    

              ],
            ),
          ),
        );
      },
    );
  }
}
