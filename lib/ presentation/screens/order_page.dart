import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/%20presentation/providers/order/order_viewmodel.dart';
import 'package:timerflow/%20presentation/widgets/drawer/drawer.dart';
import 'package:timerflow/%20presentation/widgets/order_widget/orderdrink_item.dart';
import 'package:timerflow/%20presentation/widgets/order_widget/orderfood_item.dart';
import 'package:timerflow/config/constant/app_constant.dart';
import 'package:timerflow/config/theme/ligth_theme.dart';
import 'package:timerflow/routers/app_routers.dart';
import 'package:timerflow/utils/formatter/number_formatted.dart';

class OrderPage extends StatefulWidget {
  final int sessionId;
  const OrderPage({super.key, required this.sessionId});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final orderViewModel =
          Provider.of<OrderViewModel>(context, listen: false);
      orderViewModel.fetchDrinkOrdersBySessionId(widget.sessionId);
      orderViewModel.fetchFoodOrdersBySessionId(widget.sessionId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer<OrderViewModel>(
      builder: (context, viewModel, child) {
        final totalPrice = NumberFormatter.price(viewModel.totalOrderPrice);

        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text('order_title'.tr),
              bottom:  TabBar(
                tabs: [
                  Tab(text: 'drink'.tr),
                  Tab(text: 'food'.tr),
                ],
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.addOrder,
                      arguments: widget.sessionId,
                    );
                  },
                  icon: Icon(Icons.add),
                ),
              ],
            ),
            bottomNavigationBar: Container(
              color: mainColor,
              child: Padding(
                padding: EdgeInsets.all(AppConstant.padding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "total_sum".tr,
                      style: GoogleFonts.pridi(textStyle: theme.textTheme.titleLarge!.copyWith(color: theme.scaffoldBackgroundColor),),
                    ),
                    Text("$totalPrice so'm",style: GoogleFonts.pridi(textStyle: theme.textTheme.titleLarge!.copyWith(color: theme.scaffoldBackgroundColor),),),
                  ],
                ),
              ),
            ),
            body: viewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : TabBarView(
                    children: [
                      // Ichimliklar
                      viewModel.drinkOrders.isEmpty
                          ?  Center(
                              child: Text('order_drink_empty'.tr))
                          : ListView.builder(
                              padding: const EdgeInsets.all(16),
                              itemCount: viewModel.drinkOrders.length,
                              itemBuilder: (context, index) {
                                final order = viewModel.drinkOrders[index];
                                return DrinkOrderItem(order: order);
                              },
                            ),

                      // Ovqatlar
                      viewModel.foodOrders.isEmpty
                          ?  Center(child: Text('order_food_empty'.tr))
                          : ListView.builder(
                              padding: const EdgeInsets.all(16),
                              itemCount: viewModel.foodOrders.length,
                              itemBuilder: (context, index) {
                                final order = viewModel.foodOrders[index];
                                return FoodOrderItem(order: order);
                              },
                            ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
