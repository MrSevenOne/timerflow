import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/models/table/table_model.dart';
import 'package:timerflow/presentation/viewmodel/service/table/tables_viewmodel.dart';
import 'package:timerflow/utils/user_manager.dart';

class TablesScreen extends StatefulWidget {
  const TablesScreen({super.key});

  @override
  State<TablesScreen> createState() => _TablesScreenState();
}

class _TablesScreenState extends State<TablesScreen> {

bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final vm = context.read<TableViewModel>();
      vm.loadTables(); // <-- Ilova ochilganda avtomatik load qilamiz
      _initialized = true;
    }
  }
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<TableViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tables (Offline-first)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => vm.refresh(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTable = TableModel(
            name: 'Table ${vm.tables.length + 1}',
            type: 'Pool',
            hourPrice: 50,
            userId: UserManager.userId, // UserManager ichida set qilamiz repository da
          );
          await vm.addTable(newTable);
        },
        child: const Icon(Icons.add),
      ),
      body: Builder(
        builder: (_) {
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (vm.errorMessage != null) {
            return Center(child: Text('Error: ${vm.errorMessage}'));
          }

          if (vm.tables.isEmpty) {
            return const Center(child: Text('No tables'));
          }

          return ListView.builder(
            itemCount: vm.tables.length,
            itemBuilder: (context, index) {
              final table = vm.tables[index];

              // 🔹 Status matni (Hive / API)
              final statusText =
                  table.isSynced ? 'Synced (API)' : 'Local (Hive)';

              // 🔹 Console print
              print('Table "${table.name}" source: $statusText');

              return ListTile(
                title: Text(table.name),
                subtitle: Text(
                  'Price: ${table.hourPrice} | Source: $statusText',
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    // await vm.deleteTable(table.id);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
