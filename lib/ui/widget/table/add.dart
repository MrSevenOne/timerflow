import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/config/constants.dart';
import 'package:timerflow/domain/models/table_model.dart';
import 'package:timerflow/ui/auth/view_model/tables_viewmodel.dart';
import 'package:timerflow/utils/theme/light_theme.dart';

class TableAddWidget extends StatelessWidget {
  const TableAddWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController = TextEditingController();
    TextEditingController _nuberController = TextEditingController();
    TextEditingController _horlyPriceController = TextEditingController();
    final ValueNotifier<String?> _status = ValueNotifier<String?>(null);
    final List<String> statusOptions = [
      'bo\'sh',
      'band',
      'Xizmat faoliyatida emas',
    ];

    final theme = Theme.of(context);
    return Consumer<TablesViewModel>(
      builder: (context, provider, child) {
        return AlertDialog(
          title: Text(
            'Add Table',
            style: theme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          content: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.padding / 2),
            child: Column(
              spacing: AppConstants.padding,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                
                  decoration: InputDecoration(hintText: 'name'),
                  controller: _nameController,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: 'number'),
                  controller: _nuberController,
                ),
                TextField(
                  controller: _horlyPriceController,
                  decoration: InputDecoration(hintText: 'hourly price'),
                ),
                ValueListenableBuilder<String?>(
                  valueListenable: _status,
                  builder: (context, value, _) {
                    return DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        hintText: 'status',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      value: value,
                      items: statusOptions.map((status) {
                        return DropdownMenuItem(
                          value: status,
                          child: Text(status),
                        );
                      }).toList(),
                      onChanged: (selected) {
                        _status.value = selected;
                        print(_status.value);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
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
                double hourlyPrice = double.parse(_horlyPriceController.text);
                int number = int.parse(_nuberController.text);
                final tableModel = TableModel(
                  name: _nameController.text,
                  status: _status.value.toString(),
                  rate_per_hour: hourlyPrice,
                  number: number,
                );
                // UPLOAD DATA FROM PROVIDER
                provider.addTable(tablemodel: tableModel);
                _nameController.clear();
                _nuberController.clear();
                _status.value == null;
                _horlyPriceController.clear();
                Navigator.pop(context);
              },
              child: Text(
                'add',
                style: theme.textTheme.labelLarge?.copyWith(color: mainColor),
              ),
            ),
          ],
        );
      },
    );
  }

  static void showAddDialog1({required BuildContext context}) async {
    showDialog(
      context: context,
      builder: (context) {
        return TableAddWidget();
      },
    );
  }
}
