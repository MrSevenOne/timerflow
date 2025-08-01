import 'package:responsive_framework/responsive_framework.dart';
import 'package:timerflow/%20presentation/widgets/drawer/drawer.dart';
import 'package:timerflow/exports.dart';
import 'package:timerflow/utils/responsive_wrap.dart';

class TablesPage extends StatefulWidget {
  const TablesPage({super.key});

  @override
  State<TablesPage> createState() => _HomePageState();
}

class _HomePageState extends State<TablesPage> {
  @override
  void initState() {
    super.initState();
    // Sahifa ochilganda ma'lumotlarni yuklash
    Future.microtask(() {
      Provider.of<TableProvider>(context, listen: false).getTables();
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      drawer: AppDrawer(),
      floatingActionButton: FloatingActionButton(onPressed: () {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AddTableDialogWidget(
        onSubmit: (table) {
          Provider.of<TableProvider>(context, listen: false).addTable(table);
        },
      ),
    );
  },
      child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Stollar"),
      
      ),
      body: Consumer<TableProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(child: Text("Xatolik: ${provider.error}"));
          }

          if (provider.tables.isEmpty) {
            return const Center(child: Text("Stollar topilmadi"));
          }

            return ResponsiveWrap(children: provider.tables.map((table) {
          return SizedBox(
            child: TableItems(table: table),
          );
        }).toList(),);



        },
      ),
    );
  }
}
