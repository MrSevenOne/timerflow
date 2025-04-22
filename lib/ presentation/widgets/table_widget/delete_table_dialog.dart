// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/%20presentation/providers/tables_viewmodel.dart';

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
      builder: (_) => Dialog(
        child: DeleteTableDialog(tableModel: tableModel),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tableProvider = Provider.of<TableViewModel>(context, listen: false);
    return AlertDialog(
      title: Text("data"),
      content: Text('${tableModel.name} nomli table o\'chirilsinmi?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("bekor qilish"),
        ),
        TextButton(
          onPressed: () async {
            await tableProvider.deleteTable(tableModel.id!);
            // ignore: use_build_context_synchronously
            Navigator.pop(context);
          },
          child: Text('tasdiqlash'),
        ),
      ],
    );
  }
}
