import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:timerflow/%20presentation/widgets/table_widget/delete_table_dialog.dart';
import 'package:timerflow/domain/models/table_model.dart';

class TableItem extends StatelessWidget {
  final TableModel table;
  final VoidCallback onTap;

  const TableItem({
    super.key,
    required this.table,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(table.id),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          IconButton(onPressed: () {
              DeleteTableDialog.show(
                context: context,
                tableModel: table,
              );
            }, icon: Icon(Icons.delete,color: Colors.red,),),
        ],
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: ListTile(
          leading: CircleAvatar(
            child: Text(table.number.toString()),
          ),
          title: Text(table.name),
          subtitle: Text('Narx: ${table.price}'),
          trailing: Text('Holati: ${table.status}'),
          onTap: onTap,
        ),
      ),
    );
  }
}
