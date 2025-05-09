import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/%20presentation/providers/order/order_viewmodel.dart';
import 'package:timerflow/%20presentation/providers/session/session_report_viewmodel.dart';
import 'package:timerflow/%20presentation/providers/session/session_viewmodel.dart';
import 'package:timerflow/%20presentation/widgets/session_widget/session_completion.dart';
import 'package:timerflow/%20presentation/widgets/session_widget/session_info.dart';
import 'package:timerflow/config/constant/app_constant.dart';
import 'package:timerflow/routers/app_routers.dart';
import 'package:timerflow/utils/formatter/date_formatter.dart';
import 'package:timerflow/utils/formatter/number_formatted.dart';

class SessionPage extends StatefulWidget {
  final int tableId;
  const SessionPage({super.key, required this.tableId});

  @override
  State<SessionPage> createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final sessionViewModel =
          Provider.of<SessionViewModel>(context, listen: false);
      final orderViewModel =
          Provider.of<OrderViewModel>(context, listen: false);

      await sessionViewModel.fetchSessionByTableId(tableId: widget.tableId);

      final sessionId = sessionViewModel.session?.id;
      await orderViewModel.fetchDrinkOrdersBySessionId(sessionId!);
      await orderViewModel.fetchFoodOrdersBySessionId(sessionId);
    });
  }
  


  @override
  Widget build(BuildContext context) {
    
    return Consumer3<SessionViewModel, OrderViewModel, SessionReportViewModel>(
      builder: (context, sessionViewModel, orderViewModel,
          sessionReportViewModel, _) {
            
        if (sessionViewModel.isLoading) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }

        if (sessionViewModel.error != null) {
          return Scaffold(
              body: Center(child: Text('Xatolik: ${sessionViewModel.error}')));
        }

        if (sessionViewModel.session == null) {
          return const Scaffold(body: Center(child: Text('Session topilmadi')));
        }

        final startTime = DateFormatter.formatWithMonth(
            date: sessionViewModel.session!.start_time);
        final elapsed = sessionViewModel.elapsedTime;
        final tablePrice = NumberFormatter.price(sessionViewModel.tablePrice);
        final orderPrice =
            NumberFormatter.price(orderViewModel.totalOrderPrice);
        final total =
            sessionViewModel.tablePrice + orderViewModel.totalOrderPrice;
        final totalPrice = NumberFormatter.price(total);
        final table = sessionViewModel.session?.tableModel;

        return Scaffold(
          appBar: AppBar(title: Text('${table?.name} ${table?.number}')),
          body: Padding(
            padding: EdgeInsets.all(AppConstant.padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SessionInfoRow(title: 'Boshlangan vaqt:', value: startTime),
                SessionInfoRow(title: 'O\'tgan vaqt:', value: elapsed),
                SessionInfoRow(
                    title: 'Stol narxi:', value: '$tablePrice so\'m'),
                SessionInfoRow(title: 'Bar narxi:', value: '$orderPrice so\'m'),
                SessionInfoRow(title: 'Jami narx:', value: '$totalPrice so\'m'),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(
                bottom: AppConstant.padding * 2,
                right: AppConstant.padding,
                left: AppConstant.padding),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      AppRoutes.order,
                      arguments: sessionViewModel.session?.id,
                    ),
                    child: Text('buyurtmalar'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => SessionCompletionDialog.show(context: context, sessionViewModel: sessionViewModel, orderViewModel: orderViewModel, sessionReportViewModel: sessionReportViewModel,tableId: widget.tableId,),
                    child: Text('yakunlash'),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
