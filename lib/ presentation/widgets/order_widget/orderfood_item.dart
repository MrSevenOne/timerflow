import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timerflow/domain/models/orders_model.dart';

class FoodOrderItem extends StatelessWidget {
  final OrderFoodModel order;

  const FoodOrderItem({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: ListTile(
        title: Text(order.foodModel?.name ?? 'Nomaʼlum',style: GoogleFonts.pridi(textStyle: theme.textTheme.titleLarge)),
        trailing: Text('${'amount'.tr}: ${order.quantity}',style: theme.textTheme.labelMedium,),
        subtitle: Text('${'price'.tr}:${order.foodModel?.price ?? 0} so\'m',style: theme.textTheme.labelMedium,),
      ),
    );
  }
}
