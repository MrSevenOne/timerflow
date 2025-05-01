import 'package:flutter/material.dart';
import 'package:timerflow/%20presentation/widgets/order_widget/add/add_drink.dart';
import 'package:timerflow/%20presentation/widgets/order_widget/add/add_food.dart';

class AddOrderPage extends StatelessWidget {
  final int sessionId;
  const AddOrderPage({super.key,required this.sessionId});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Ikki tab, biri food, biri drink
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Buyurtma Qo‘shish'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Ichimliklar'),
              Tab(text: 'Ovqatlar'),
            ],
          ),
        ),
        body:  TabBarView(
          children: [
            DrinkTab(sessionId: sessionId), // Ichimliklar ro'yxati
            FoodTab(sessionId: sessionId), // Ovqatlar ro'yxati
          ],
        ),
      ),
    );
  }
}
