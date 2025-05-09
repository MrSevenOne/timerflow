import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/%20presentation/providers/food/food_viewmodel.dart';
import 'package:timerflow/%20presentation/providers/order/order_viewmodel.dart';
import 'package:timerflow/%20presentation/widgets/QuantitySelector.dart';
import 'package:timerflow/%20presentation/widgets/order_widget/add/add_info.dart';
import 'package:timerflow/domain/models/food_model.dart';
import 'package:timerflow/domain/models/orders_model.dart';

class AddOrderFoodDialog extends StatelessWidget {
  final FoodModel foodModel;
  final int sessionId;
  const AddOrderFoodDialog(
      {super.key, required this.foodModel, required this.sessionId});

  static void show({
    required BuildContext context,
    required FoodModel foodModel,
    required int sessionId,
  }) {
    showDialog(
      context: context,
      builder: (context) => AddOrderFoodDialog(
        foodModel: foodModel,
        sessionId: sessionId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<FoodViewModel, OrderViewModel>(
      builder: (context, foodViewModel, orderViewModel, child) {
        int selectedQuantity = 1;
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                foodModel.name,
                textAlign: TextAlign.center,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OrderAddInfo(
                      title: "Soni:", value: '${foodModel.amount} dona'),
                  OrderAddInfo(title: "Narxi:", value: '${foodModel.price}'),
                  QuantitySelector(
                    initialValue: selectedQuantity,
                    onChanged: (value) {
                      setState(() {
                        selectedQuantity = value;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    debugPrint("session id: $sessionId");

                    OrderFoodModel order = OrderFoodModel(
                      sessionId: sessionId,
                      foodId: foodModel.id!,
                      quantity: selectedQuantity,
                    );

                    // Buyurtmani yozishni bazaga yozish
                    await orderViewModel.addFoodOrder(order: order);

                    // Mahsulot miqdorini kamaytirish
                    await foodViewModel.updateAmountFood(
                      foodId: foodModel.id!,
                      orderedQuantity: selectedQuantity,
                    );

                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  },
                  child: const Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
