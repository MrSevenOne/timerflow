import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/config/constants.dart';
import 'package:timerflow/domain/models/table_model.dart';
import 'package:timerflow/ui/auth/view_model/tables_viewmodel.dart';
import 'package:timerflow/utils/theme/light_theme.dart';

class TableDelete extends StatelessWidget {
  TableModel tableModel;
  TableDelete({super.key, required this.tableModel});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer<TablesViewModel>(
      builder: (context, provider, child) {
        return AlertDialog(
          title: Text(
            'Add Table',
            style: theme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          content: Text('Delete the table?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('cencal',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.error,
                  )),
            ),
            TextButton(
              onPressed: () {
                provider.deleteTable(tablemodel: tableModel);
                Navigator.pop(context);
              },
              child: Text(
                'delete',
                style: theme.textTheme.labelLarge?.copyWith(color: mainColor),
              ),
            ),
          ],
        );
      },
    );
  }

  static void TableDeleteDialog(
      {required BuildContext context, required TableModel tableModel}) {
    showDialog(
      context: context,
      builder: (context) {
        return TableDelete(tableModel: tableModel);
      },
    );
  }
}
