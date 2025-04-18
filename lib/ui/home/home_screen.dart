import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/config/constants.dart';
import 'package:timerflow/ui/auth/view_model/tables_viewmodel.dart';
import 'package:timerflow/ui/widget/table/add.dart';
import 'package:timerflow/ui/widget/table/tablecard.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ma'lumotlarni bir marta yuklash
    Future.microtask(() =>
        Provider.of<TablesViewModel>(context, listen: false).getTables());
        final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text('Home Screen')),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.padding/2),
        child: Consumer<TablesViewModel>(
          builder: (context, provider, child) {
            if (provider.isLoading && provider.table.isEmpty) {
              return Center(child: CircularProgressIndicator());
            }
        
            return RefreshIndicator(
              onRefresh: () => provider.getTables(), // 🔄 Pull-to-refresh
              child: provider.table.isEmpty
                  ? ListView(
                      children: const [
                        SizedBox(height: 300),
                        Center(child: Text("Table mavjud emas")),
                      ],
                    )
                  : ListView.builder(
                  
  itemCount: provider.table.length,
  itemBuilder: (context, index) {
    final table = provider.table[index];
    return TableCard(table: table,index: index,); 
  },
),

            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          TableAddWidget.showAddDialog1(context: context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
