import 'package:timerflow/%20presentation/screens/bar/bar_page.dart';
import 'package:timerflow/%20presentation/screens/reports/reports_page.dart';
import 'package:timerflow/%20presentation/widgets/drawer/drawer.dart';
import 'package:timerflow/exports.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    TablesPage(),
    BarPage(),
    ReportsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items:  [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home'.tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: "bar".tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "reports".tr,
          ),
        ],
      ),
    );
  }
}