import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:timerflow/%20presentation/widgets/drink_widget/delete_drink_dialog.dart';
import 'package:timerflow/%20presentation/widgets/drink_widget/edit_drink_dialog.dart';
import 'package:timerflow/domain/models/drink_model.dart';

class DrinkItem extends StatelessWidget {
  final DrinkModel drink;
  final VoidCallback onTap;

  const DrinkItem({
    super.key,
    required this.drink,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(drink.id),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          IconButton(
            onPressed: () {
              EditDrinkDialog.show(context, drinkModel: drink);
            },
            icon: const Icon(Icons.edit, color: Colors.blue),
          ),
          IconButton(
            onPressed: () {
              DeleteDrinkDialog.show(context, drinkModel: drink);
            },
            icon: const Icon(Icons.delete, color: Colors.red),
          ),
        ],
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: ListTile(
          title: Text(drink.name),
          subtitle: Text(
              'Narx: ${drink.price} so‘m | Hajmi: ${drink.volume} ml | Mavjud: ${drink.amount} dona'),
          onTap: onTap,
        ),
      ),
    );
  }
}
