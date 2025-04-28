import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/%20presentation/providers/tables_viewmodel.dart';
import 'package:timerflow/domain/models/session_model.dart';
import '../../../routers/app_routers.dart';
import '../../providers/session_viewmodel.dart';

class StartSessionDialog extends StatelessWidget {
  final SessionModel sessionModel;
  const StartSessionDialog({super.key, required this.sessionModel});

  static Future<void> show(
      {required BuildContext context,
      required SessionModel sessionModel}) async {
    await showDialog(
      context: context,
      builder: (_) => StartSessionDialog(sessionModel: sessionModel),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Band qilish"),
      content:
          Text('${sessionModel.tableModel?.name} nomli tableni band qilish'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("bekor qilish"),
        ),
        TextButton(
          onPressed: () async {
            final session =
                Provider.of<SessionViewModel>(context, listen: false);
            final tableViewModel =
                Provider.of<TableViewModel>(context, listen: false);

            await session.addSession(
              sessionModel: sessionModel,
              tableId: sessionModel.table_id,
              status: 'busy',
            );

            // ignore: use_build_context_synchronously
            Navigator.pop(context); 

            await tableViewModel.fetchTables(); // <<== yangilashni qo‘shamiz
            if (context.mounted) {
              Navigator.pop(context);
              Navigator.pushNamed(
                context,
                AppRoutes.session,
                arguments: sessionModel,
              );
            }
          },
          child: Text('tasdiqlash'),
        ),
      ],
    );
  }
}
