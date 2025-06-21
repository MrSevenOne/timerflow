// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/%20presentation/providers/table/tables_viewmodel.dart';

import 'package:timerflow/domain/models/table_model.dart';

class DeleteTableDialog extends StatelessWidget {
  final TableModel tableModel;
  const DeleteTableDialog({
    super.key,
    required this.tableModel,
  });

  static Future<void> show(
      {required BuildContext context, required TableModel tableModel}) async {
    await showDialog(
      context: context,
      builder: (_) => 
         DeleteTableDialog(tableModel: tableModel),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tableProvider = Provider.of<TableViewModel>(context, listen: false);
    return AlertDialog(
      title: Text("delete".tr),
      content: Text('${tableModel.name} ${'table_delete'.tr}'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("cencal".tr),
        ),
        TextButton(
          onPressed: () async {
            await tableProvider.deleteTable(tableModel.id!);
            // ignore: use_build_context_synchronously
            Navigator.pop(context);
          },
          child: Text('confirmation'.tr),
        ),
      ],
    );
  }
}
