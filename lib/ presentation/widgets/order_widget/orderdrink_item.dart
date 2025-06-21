import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timerflow/domain/models/orders_model.dart';

class DrinkOrderItem extends StatelessWidget {
  final OrderDrinkModel order;

  const DrinkOrderItem({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: ListTile(
        title: Text(
            '${order.drinkModel?.name ?? 'Nomaʼlum'} ${order.drinkModel?.volume ?? ''}ml',
            style: GoogleFonts.pridi(textStyle: theme.textTheme.titleLarge)),
        trailing: Text('${'amount'.tr}: ${order.quantity}',style: theme.textTheme.labelMedium,),
        subtitle: Text('${'price'.tr}: ${order.drinkModel?.price ?? 0} so\'m',style: theme.textTheme.labelMedium,),
      ),
    );
  }
}
