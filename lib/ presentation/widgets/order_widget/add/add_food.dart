import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/%20presentation/providers/food/food_viewmodel.dart';
import 'package:timerflow/%20presentation/widgets/food_widget/food_item.dart';
import 'package:timerflow/%20presentation/widgets/order_widget/add/show_dialog/add_food_dialog.dart';

class FoodTab extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final sessionId;
  const FoodTab({super.key, required this.sessionId});

  @override
  State<FoodTab> createState() => _FoodTabState();
}

class _FoodTabState extends State<FoodTab> {
  @override
  void initState() {
    super.initState();
    // ViewModel dan stol ma'lumotlarini olish
    Future.microtask(() =>
        // ignore: use_build_context_synchronously
        Provider.of<FoodViewModel>(context, listen: false).getFood());
  }

  @override
  Widget build(BuildContext context) {
    // FoodViewModel orqali food ro'yxatini olamiz
    return Consumer<FoodViewModel>(
      builder: (context, foodViewModel, child) {
        if (foodViewModel.isLoading) {
          return Center(child: Text('loading....'));
        } else if (foodViewModel.foodList.isEmpty) {
          return Center(
            child: Text('Food mavjud emas'),
          );
        }
        return ListView.builder(
          itemCount: foodViewModel.foodList.length,
          itemBuilder: (context, index) {
            final foods = foodViewModel.foodList[index];
            return FoodItem(
              food: foods,
              onTap: () =>
                  AddOrderFoodDialog.show(context: context, foodModel: foods,sessionId: widget.sessionId,),
            );
          },
        );
      },
    );
  }
}
