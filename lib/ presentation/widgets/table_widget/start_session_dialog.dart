import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/%20presentation/providers/table/tables_viewmodel.dart';
import 'package:timerflow/config/theme/ligth_theme.dart';
import 'package:timerflow/domain/models/session_model.dart';
import '../../../routers/app_routers.dart';
import '../../providers/session/session_viewmodel.dart';

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
    final theme = Theme.of(context);
    return AlertDialog(
      title: Text("booking".tr),
      content:
          Text('${sessionModel.tableModel?.name} ${'busy_table'.tr}'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("cencal".tr,style: TextStyle(color: theme.colorScheme.error,),),
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
              status: 1,
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
          child: Text('confirmation'.tr,style: TextStyle(color: mainColor),),
        ),
      ],
    );
  }
}
