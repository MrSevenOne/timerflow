import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/%20presentation/providers/drink/drink_viewmodel.dart';
import 'package:timerflow/%20presentation/widgets/drink_widget/drink_item.dart';
import 'package:timerflow/%20presentation/widgets/order_widget/add/show_dialog/add_drink_dialog.dart';

class DrinkTab extends StatefulWidget {
  final int sessionId;
  const DrinkTab({super.key, required this.sessionId});

  @override
  State<DrinkTab> createState() => _DrinkTabState();
}

class _DrinkTabState extends State<DrinkTab> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        // ignore: use_build_context_synchronously
        Provider.of<DrinkViewModel>(context, listen: false).getDrinks());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DrinkViewModel>(
      builder: (context, drinkViewModel, child) {
        if (drinkViewModel.isLoading) {
          return const Center(child: Text('loading...'));
        } else if (drinkViewModel.drinkList.isEmpty) {
          return  Center(child: Text('drink_empty'.tr));
        }
        return ListView.builder(
          itemCount: drinkViewModel.drinkList.length,
          itemBuilder: (context, index) {
            final drink = drinkViewModel.drinkList[index];
            return DrinkItem(
              drink: drink,
              onTap: () => AddOrderDrinkDialog.show(
                context: context,
                drinkModel: drink,
                sessionId: widget.sessionId,
              ),
            );
          },
        );
      },
    );
  }
}
