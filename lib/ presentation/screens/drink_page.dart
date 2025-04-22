import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/%20presentation/providers/drink_viewmodel.dart';
import 'package:timerflow/%20presentation/widgets/drink_widget/add_drink_dialog.dart';
import 'package:timerflow/%20presentation/widgets/drink_widget/drink_item.dart';


class DrinkPage extends StatefulWidget {
  const DrinkPage({super.key});

  @override
  State<DrinkPage> createState() => _DrinkPageState();
}

class _DrinkPageState extends State<DrinkPage> {
   @override
  void initState() {
    super.initState();
    // ViewModel dan stol ma'lumotlarini olish
    Future.microtask(() =>
        // ignore: use_build_context_synchronously
        Provider.of<DrinkViewModel>(context, listen: false).getDrinks());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ichimliklar ro‘yxati'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              AddDrinkDialog.show(context);
            },
          ),
        ],
      ),
      body: Consumer<DrinkViewModel>(
        builder: (context, viewModel, _) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.drinkList.isEmpty) {
            return RefreshIndicator(
              onRefresh: viewModel.getDrinks,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 200),
                  Center(child: Text('Ichimliklar mavjud emas')),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: viewModel.getDrinks,
            child: ListView.builder(
              itemCount: viewModel.drinkList.length,
              itemBuilder: (context, index) {
                final drink = viewModel.drinkList[index];
                return DrinkItem(
                  drink: drink,
                  onTap: () {
                    // Edit yoki detail funksiyasi
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
