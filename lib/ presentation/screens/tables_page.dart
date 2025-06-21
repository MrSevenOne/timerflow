import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/%20presentation/providers/table/tables_viewmodel.dart';
import 'package:timerflow/%20presentation/widgets/drawer/drawer.dart';
import 'package:timerflow/%20presentation/widgets/table_widget/add_table_dialog.dart';
import 'package:timerflow/%20presentation/widgets/table_widget/items.dart';
import 'package:timerflow/%20presentation/widgets/table_widget/start_session_dialog.dart';
import 'package:timerflow/domain/models/session_model.dart';
import 'package:timerflow/routers/app_routers.dart';
import 'package:timerflow/utils/user/user_manager.dart';

class TablePage extends StatefulWidget {
  const TablePage({super.key});

  @override
  State<TablePage> createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  @override
  void initState() {
    super.initState();
    // ViewModel dan stol ma'lumotlarini olish
    Future.microtask(() =>
        // ignore: use_build_context_synchronously
        Provider.of<TableViewModel>(context, listen: false).fetchTables());
  }

  @override
  Widget build(BuildContext context) {
    final userId = UserManager.currentUserId;
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title:  Text('table_title'.tr),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              AddTableDialog.show(context);
            },
          ),
        ],
      ),
      body: Consumer<TableViewModel>(
        builder: (context, viewModel, child) {
          return RefreshIndicator(
            onRefresh: viewModel.fetchTables,
            child: viewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : viewModel.tables.isEmpty
                    ?  Center(child: Text('table_page_empty'.tr))
                    : ListView.builder(
                        itemCount: viewModel.tables.length,
                        itemBuilder: (context, index) {
                          final table = viewModel.tables[index];
                          return TableItem(
                            table: table,
                            onTap: () {
                              final sessionModel = SessionModel(
                                table_id: table.id!,
                                start_time: DateTime.now(),
                                tableModel: table,
                                userId: userId,
                              );

                              if (table.status == 0) {
                                StartSessionDialog.show(
                                    context: context,
                                    sessionModel: sessionModel);
                              } else if (table.status == 1) {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.session,
                                  arguments: table.id,
                                );
                              } else {
                                debugPrint("bu Table Service holatda");
                              }
                            },
                          );
                        },
                      ),
          );
        },
      ),
    );
  }
}
