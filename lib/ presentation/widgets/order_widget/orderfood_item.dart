import 'package:flutter/material.dart';
import 'package:timerflow/domain/models/orders_model.dart';

class FoodOrderItem extends StatelessWidget {
  final OrderFoodModel order;

  const FoodOrderItem({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(order.foodModel?.name ?? 'Nomaʼlum'),
        trailing: Text('Soni: ${order.quantity}'),
        subtitle: Text('Narxi: ${order.foodModel?.price ?? 0} so\'m'),
      ),
    );
  }
}
