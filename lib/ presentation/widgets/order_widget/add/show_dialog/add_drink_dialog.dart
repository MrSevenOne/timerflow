import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/%20presentation/providers/drink/drink_viewmodel.dart';
import 'package:timerflow/%20presentation/providers/order/order_viewmodel.dart';
import 'package:timerflow/%20presentation/widgets/QuantitySelector.dart';
import 'package:timerflow/%20presentation/widgets/order_widget/add/add_info.dart';
import 'package:timerflow/domain/models/drink_model.dart';
import 'package:timerflow/domain/models/orders_model.dart';

class AddOrderDrinkDialog extends StatelessWidget {
  final DrinkModel drinkModel;
  final int sessionId;

  const AddOrderDrinkDialog({
    super.key,
    required this.drinkModel,
    required this.sessionId,
  });

  static void show({
    required BuildContext context,
    required DrinkModel drinkModel,
    required int sessionId,
  }) {
    showDialog(
      context: context,
      builder: (context) =>
          AddOrderDrinkDialog(drinkModel: drinkModel, sessionId: sessionId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<DrinkViewModel, OrderViewModel>(
      builder: (context, drinkViewModel, orderViewModel, child) {
        int selectedQuantity = 1;

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                drinkModel.name,
                textAlign: TextAlign.center,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OrderAddInfo(
                      title: "${'amount'.tr}:", value: '${drinkModel.amount} ${'piece'.tr}'),
                  OrderAddInfo(title: "${'price'.tr}:", value: '${drinkModel.price}'),
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
                  child:  Text('cencal'.tr),
                ),
                TextButton(
                  onPressed: () async {
                    debugPrint("session id: $sessionId");

                    OrderDrinkModel order = OrderDrinkModel(
                      sessionId: sessionId,
                      drinkId: drinkModel.id!,
                      quantity: selectedQuantity,
                    );

                    await orderViewModel.addDrinkOrder(order: order);
                    await drinkViewModel.updateAmountDrink(
                      drinkId: drinkModel.id!,
                      orderedQuantity: selectedQuantity,
                    );
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  },
                  child:  Text('add'.tr),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
