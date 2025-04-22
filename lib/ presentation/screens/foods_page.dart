import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/%20presentation/providers/food_viewmodel.dart';
import 'package:timerflow/%20presentation/widgets/food_widget/delete_food_dialog.dart';
import 'package:timerflow/%20presentation/widgets/food_widget/food_item.dart';
import 'package:timerflow/%20presentation/widgets/food_widget/add_food_dialog.dart';

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
      appBar: AppBar(
        title: const Text('Taomlar ro‘yxati'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              AddFoodDialog.show(context);
            },
          ),
        ],
      ),
      body: Consumer<FoodViewModel>(
        builder: (context, viewModel, child) {
          return RefreshIndicator(
            onRefresh: viewModel.getFood,
            child: viewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : viewModel.foodList.isEmpty
                    ? const Center(child: Text('Hozircha taom mavjud emas'))
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
    );
  }
}
