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

    // TableViewModel ni init qilish
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TableViewModel>().init();
    });
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
        title: const Text("Stollar"),
        actions: [
          IconButton(
            icon: const Icon(Icons.sync),
            onPressed: () async => await vm.syncTables(),
            tooltip: "Sinxronizatsiya",
          ),
        ],
      ),
      body: vm.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Tarif bo‘yicha ruxsat etilgan stol limiti: ",
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
                        subtitle: Text(
                            "Narxi: ${table.hourPrice} so‘m/soat | Turi: ${table.type}"),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _confirmDelete(table),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          debugPrint("Table Add button bosilmoqda :)");
          _showAddDialog();
        },
      ),
    );
  }

  /// Add table dialog
  void _showAddDialog() {
    final _nameController = TextEditingController();
    final _typeController = TextEditingController(text: "billiard");
    final _priceController = TextEditingController(text: "20000");

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Yangi stol qo‘shish"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Stol nomi"),
            ),
            TextField(
              controller: _typeController,
              decoration: const InputDecoration(labelText: "Turi"),
            ),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: "So‘m/soat"),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text("Bekor qilish"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: const Text("Qo‘shish"),
            onPressed: () async {
              final name = _nameController.text.trim();
              final type = _typeController.text.trim();
              final price = int.tryParse(_priceController.text.trim()) ?? 0;

              if (name.isEmpty || price <= 0) {
                context.showWarning("Iltimos, barcha maydonlarni to‘ldiring!");
                return;
              }

              final vm = context.read<TableViewModel>();
              await vm.addTable(
                name: name,
                type: type,
                hourPrice: price,
                userId: UserManager().requireUserId(),
              );

              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  /// Delete confirm dialog
  void _confirmDelete(TableModel table) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Stolni o‘chirish"),
        content: Text("Siz '${table.name}' stolni o‘chirmoqchimisiz?"),
        actions: [
          TextButton(
            child: const Text("Bekor qilish"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: const Text("O‘chirish"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              final vm = context.read<TableViewModel>();
              await vm.deleteTable(table.localId);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

/// Offline ekran (internet yo‘q bo‘lganda)
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
