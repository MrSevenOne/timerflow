import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/domain/models/table_model.dart';
import 'package:timerflow/ui/auth/view_model/session_viewmodel.dart';

class TableDetailPage extends StatefulWidget {
  final TableModel tableModel;
  const TableDetailPage({super.key, required this.tableModel});

  @override
  State<TableDetailPage> createState() => _TableDetailPageState();
}

class _TableDetailPageState extends State<TableDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tableModel.name),
      ),
      body: Consumer<SessionViewModel>(
        builder: (context, provider, child) {
          return Column(
            children: [
              
            ],
          );
        },
      ),
    );
  }
}
