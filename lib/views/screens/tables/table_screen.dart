import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/models/table_model.dart';
import 'package:timerflow/providers/service/table_viewmodel.dart';
import 'package:timerflow/services/remote/user_manager.dart';
import 'package:timerflow/utils/extension/snackbar_extension.dart';

class TableScreen extends StatefulWidget {
  const TableScreen({super.key});

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  @override
  void initState() {
    super.initState();

    // 3️⃣ Init TableViewModel
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TableViewModel>().init();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<TableViewModel>();

    // SnackBar xabarlarini avtomatik ko‘rsatish
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (vm.errorMessage != null) {
        context.showWarning(vm.errorMessage!);
        vm.clearMessages();
      }
      if (vm.successMessage != null) {
        context.showSuccess(vm.successMessage!);
        vm.clearMessages();
      }
    });

    return Scaffold(
        appBar: AppBar(
          title: const Text("Stol Test Page"),
        ),
        body: vm.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "Tarif bo‘yicha ruxsat etilgan stol limiti: ${vm.userTableLimit}",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "Yaratilgan stollar: ${vm.tables.length}",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: vm.tables.length,
                      itemBuilder: (context, index) {
                        final table = vm.tables[index];
                        return ListTile(
                          title: Text(table.name),
                          subtitle: Text("Narxi: ${table.hourPrice} so‘m/soat"),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              if (table.serverId != null) {
                                vm.deleteTable(table.serverId!);
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            await vm.addTable(
              TableModel(
                name: "Yangi Stol ${vm.tables.length + 1}",
                type: "billiard",
                hourPrice: 20000,
                userId: UserManager().requireUserId(),
              ),
            );
          },
        ),
      
    );
  }
}

class OfflineScreen extends StatelessWidget {
  const OfflineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.wifi_off, size: 80, color: Colors.red),
            SizedBox(height: 20),
            Text(
              "Internet uzildi!\nIltimos qayta ulanishni kuting...",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
