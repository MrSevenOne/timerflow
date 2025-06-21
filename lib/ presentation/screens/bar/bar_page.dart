import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:timerflow/%20presentation/screens/drink_page.dart';
import 'package:timerflow/%20presentation/screens/foods_page.dart';
import 'package:timerflow/%20presentation/widgets/drawer/drawer.dart';

class BarPage extends StatelessWidget {
  const BarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Tab soni
      child: Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
        
          title: Text("bar_title".tr),
          bottom:  TabBar(
            tabs: [
              Tab(text: 'drink'.tr),
              Tab(text: 'food'.tr),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            DrinkPage(), // Ichimliklar ro'yxati
            FoodPage(), // Ovqatlar ro'yxati
          ],
        ),
      ),
    );
  }
}
