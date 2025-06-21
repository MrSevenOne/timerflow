import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_fonts/google_fonts.dart';
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
    final theme = Theme.of(context);
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
        child: Padding(
          padding:  EdgeInsets.all(2.0),
          child: ListTile(
            leading: Container(
               width: 45,
            height: 45,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: OvalBorder(
                side: BorderSide(
                  width: 0.30,
                  color: const Color(0xFFF5F5F5),
                ),
              ),
              shadows: [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 2,
                  offset: Offset(0, 1),
                  spreadRadius: 0,
                )
              ],
            ),
              child: Center(child: Text(table.number.toString(),style: theme.textTheme.titleMedium,
              ),
            ),
            ),
            title: Text(table.name,style: GoogleFonts.pridi(textStyle: theme.textTheme.titleLarge)),
            subtitle: Text('${'price'.tr}: ${table.price}',style: theme.textTheme.labelMedium,),
            trailing: Text('${'status'.tr}: ${table.status}',style: theme.textTheme.labelMedium,),
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
