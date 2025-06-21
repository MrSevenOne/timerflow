import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/%20presentation/providers/food/food_viewmodel.dart';
import 'package:timerflow/%20presentation/widgets/food_widget/food_item.dart';
import 'package:timerflow/%20presentation/widgets/food_widget/add_food_dialog.dart';
import 'package:timerflow/config/constant/app_constant.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({super.key});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
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
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.symmetric(vertical:  AppConstant.padding/3),
        child: Consumer<FoodViewModel>(
          builder: (context, viewModel, child) {
            return RefreshIndicator(
              onRefresh: viewModel.getFood,
              child: viewModel.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : viewModel.foodList.isEmpty
                      ?  Center(child: Text('food_empty'.tr))
                      : ListView.builder(
                          itemCount: viewModel.foodList.length,
                          itemBuilder: (context, index) {
                            final food = viewModel.foodList[index];
                            return FoodItem(
                              food: food,
                              onTap: () {},
                            );
                          },
                        ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
      AddFoodDialog.show(context);
      },child: Icon(Icons.add,),
      ),
    );
  }
}
