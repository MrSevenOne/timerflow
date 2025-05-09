import 'package:flutter/material.dart';
import 'package:timerflow/%20presentation/providers/order/order_viewmodel.dart';
import 'package:timerflow/%20presentation/providers/session/session_report_viewmodel.dart';
import 'package:timerflow/%20presentation/providers/session/session_viewmodel.dart';
import 'package:timerflow/%20presentation/widgets/payment_widget/payment_dialog.dart';
import 'package:timerflow/domain/models/session_report_model.dart';

class SessionCompletionDialog extends StatelessWidget {
  final SessionViewModel sessionViewModel;
  final OrderViewModel orderViewModel;
  final SessionReportViewModel sessionReportViewModel;
  final int tableId;
  const SessionCompletionDialog({
    super.key,
    required this.sessionViewModel,
    required this.orderViewModel,
    required this.sessionReportViewModel,
    required this.tableId,
  });

  static void show({
    required BuildContext context,
    required SessionViewModel sessionViewModel,
    required OrderViewModel orderViewModel,
    required SessionReportViewModel sessionReportViewModel,
    required int tableId,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return SessionCompletionDialog(
          sessionViewModel: sessionViewModel,
          orderViewModel: orderViewModel,
          sessionReportViewModel: sessionReportViewModel,
          tableId: tableId,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Stolni tugatish",
        textAlign: TextAlign.center,
      ),
      content: Text("Bu Stolni tugatmoqchimisiz?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Bekor qilish"),
        ),
        TextButton(
          onPressed: () {
            _completeSession(
              context: context,
              sessionViewModel: sessionViewModel,
              orderViewModel: orderViewModel,
              sessionReportViewModel: sessionReportViewModel,
              tableId: tableId,
            );
          },
          child: Text("Ha"),
        ),
      ],
    );
  }
}

void _completeSession({
  required BuildContext context,
  required SessionViewModel sessionViewModel,
  required OrderViewModel orderViewModel,
  required SessionReportViewModel sessionReportViewModel,
  required int tableId,
}) async {
  if (sessionViewModel.session == null || sessionViewModel.session!.id == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Session maʼlumotlari toʻliq emas')),
    );
    return;
  }

  final sessionReportModel = SessionReportModel(
    startTime: sessionViewModel.session!.start_time,
    endTime: DateTime.now(),
    tableId: sessionViewModel.session!.table_id,
    duration: sessionViewModel.elapsedTime,
    tablePrice: sessionViewModel.tablePrice,
    orderPrice: orderViewModel.totalOrderPrice,
    sessionId: sessionViewModel.session!.id!,
  );

  await sessionReportViewModel.addReport(sessionReportModel);

  if (sessionReportViewModel.error == null) {
    if (context.mounted) {
      Navigator.pop(context);
      PaymentBottomSheet.show(context: context, tableId: tableId);
    }
  } else {
    debugPrint('Xatolik: ${sessionReportViewModel.error}');
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Xatolik: ${sessionReportViewModel.error}')),
    );
  }
}

