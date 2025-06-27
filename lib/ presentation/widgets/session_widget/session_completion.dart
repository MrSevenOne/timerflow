import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/%20presentation/providers/order/order_viewmodel.dart';
import 'package:timerflow/%20presentation/providers/session/session_viewmodel.dart';
import 'package:timerflow/%20presentation/providers/session/table_report_viewmodel.dart';
import 'package:timerflow/%20presentation/widgets/payment_widget/payment_dialog.dart';
import 'package:timerflow/domain/models/session_report_model.dart';
import 'package:timerflow/utils/user/user_manager.dart';

class SessionCompletionDialog extends StatelessWidget {
  final int tableId;

  const SessionCompletionDialog({
    super.key,
    required this.tableId,
  });

  static void show({
    required BuildContext context,
    required int tableId,
  }) {
    showDialog(
      context: context,
      builder: (_) => SessionCompletionDialog(tableId: tableId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("table_finish".tr, textAlign: TextAlign.center),
      content: Text("table_finish_want".tr),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("cencal".tr),
        ),
        TextButton(
          onPressed: () async {
            final sessionViewModel = context.read<SessionViewModel>();
            final orderViewModel = context.read<OrderViewModel>();
            final sessionReportViewModel = context.read<SessionReportViewModel>();
            final session = sessionViewModel.session;
            final userId = UserManager.currentUserId;

            if (session == null || session.id == null || userId == null) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("session_incomplete".tr)),
              );
              return;
            }

            final newReport = SessionReportModel(
              startTime: session.start_time,
              endTime: DateTime.now(),
              tableId: session.table_id,
              duration: sessionViewModel.elapsedTime,
              tablePrice: sessionViewModel.tablePrice,
              orderPrice: orderViewModel.totalOrderPrice,
              sessionId: session.id!,
              userId: userId,
            );

            final reportId = await sessionReportViewModel.addReport(newReport);

            Navigator.pop(context); // Dialogni yopamiz

            if (reportId != null) {
              PaymentBottomSheet.show(
                context: context,
                tableId: tableId,
                sessionReportId: reportId,
                sessionId: session.id!,
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("session_report_error".tr)),
              );
            }
          },
          child: Text("yes".tr),
        ),
      ],
    );
  }
}
