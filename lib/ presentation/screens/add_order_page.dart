import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
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
          title:  Text('order_add'.tr),
          bottom:  TabBar(
            tabs: [
              Tab(text: 'drink'.tr),
              Tab(text: 'food'.tr),
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
