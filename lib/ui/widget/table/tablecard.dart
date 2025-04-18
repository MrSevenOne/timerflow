import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/config/constants.dart';
import 'package:timerflow/domain/models/table_model.dart';
import 'package:timerflow/ui/auth/view_model/tables_viewmodel.dart';
import 'package:timerflow/ui/table_session/widgets/table_detail_screen.dart';
import 'package:timerflow/ui/widget/table/TableBookingDialog.dart';

class TableCard extends StatelessWidget {
  final TableModel table;
  final int index;

  const TableCard({super.key, required this.table, required this.index});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
   

    return Slidable(
      key: ValueKey(
          table.id), // table.id bo'lishi kerak, yoki name agar id yo‘q bo‘lsa
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          Builder(
            builder: (cont) {
              return ElevatedButton(
                onPressed: () {
                  Slidable.of(cont)!.close();
                  Provider.of<TablesViewModel>(context,listen: false).deleteTable(tablemodel: table);
                },
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.all(10),
                ),
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 25,
                ),
              );
            },
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6.0),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(AppConstants.radius),
        ),
        child: ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              table.name,
              style: theme.textTheme.titleMedium,
            ),
            subtitle: Text(
              table.status,
              style:
                  theme.textTheme.bodyMedium?.copyWith(color: Colors.grey[700]),
            ),
            onTap: () {
              if (table.status == 'bo\'sh') {
                // Bo'sh stol — dialog ochiladi
                BookTableDialog.showDialogBookTable(
                    context: context, tableModel: table);
              } else if(table.status == 'band') {
                // Band stol — boshqa sahifaga o'tish
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TableDetailPage(tableModel: table),
                  ),
                );
              }
            }),
      )
          .animate(delay: 100.ms)
          .fade(duration: 500.ms)
          .move(begin: const Offset(0, 10), end: Offset.zero)
          .slideY(begin: 0.2, end: 0, duration: (index * 300).ms),
    );
  }
}
