import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/domain/models/table_model.dart';
import 'package:timerflow/ui/auth/view_model/session_viewmodel.dart';

class BookTableDialog extends StatelessWidget {
  final TableModel table;

  const BookTableDialog({super.key, required this.table});

  static void showDialogBookTable(
      {required BuildContext context, required TableModel tableModel}) {
    showDialog(
      context: context,
      builder: (context) {
        return BookTableDialog(table: tableModel);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Stolni band qilish'),
      content: Text('Stol: ${table.name}'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Bekor qilish'),
        ),
        ElevatedButton(
          onPressed: () async {
            await Provider.of<SessionViewModel>(context, listen: false)
                .startSession(tableId: table.id!, context: context);
            // ignore: use_build_context_synchronously
            Navigator.pop(context);
          },
          child: Text('Band qilish'),
        ),
      ],
    );
  }
}
