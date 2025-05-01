import 'package:flutter/material.dart';
import 'package:timerflow/domain/models/orders_model.dart';

class DrinkOrderItem extends StatelessWidget {
  final OrderDrinkModel order;

  const DrinkOrderItem({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('${order.drinkModel?.name ?? 'Nomaʼlum'} ${order.drinkModel?.volume ?? ''}ml'),
        trailing: Text('Soni: ${order.quantity}'),
        subtitle: Text('Narxi: ${order.drinkModel?.price ?? 0} so\'m'),
      ),
    );
  }
}
