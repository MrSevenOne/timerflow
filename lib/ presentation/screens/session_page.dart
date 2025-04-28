import 'package:flutter/material.dart';
import 'package:timerflow/config/constant/app_constant.dart';
import 'package:timerflow/domain/models/session_model.dart';
import 'package:timerflow/utils/formatter/date_formatter.dart';
import 'package:timerflow/utils/formatter/number_formatted.dart';

import '../widgets/session_widget/session_info.dart';

class SessionPage extends StatelessWidget {
  final SessionModel sessionModel;
  const SessionPage({super.key, required this.sessionModel});

  @override
  Widget build(BuildContext context) {
    final String startTime = DateFormatter.format(date: sessionModel.start_time);
    final String tablePrice = NumberFormatter.format(sessionModel.tableModel!.price);

    return Scaffold(
      appBar: AppBar(
        title: Text(sessionModel.tableModel?.name ?? 'No Name'),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppConstant.padding),
        child: Column(
          children: [
            SessionInfoRow(title: 'Yaratilgan vaqti:', value: startTime),
            SessionInfoRow(title: 'O\'tgan vaqt:', value: startTime), // bu keyin dynamic bo'ladi
            SessionInfoRow(title: 'Stol narxi:', value: '$tablePrice so\'m'),
          ],
        ),
      ),
    );
  }
}
