import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:timerflow/%20presentation/providers/order_viewmodel.dart';
import 'package:timerflow/domain/models/orders_model.dart';

class BarOrdersList extends StatelessWidget {
  final String tableId;

  const BarOrdersList({super.key, required this.tableId});

  @override
  Widget build(BuildContext context) {
    final breakpoints = ResponsiveBreakpoints.of(context);
    final isDesktop = breakpoints.isDesktop;
    final isTablet = breakpoints.isTablet;
    return Consumer<OrderViewModel>(
      builder: (context, viewModel, _) {
        final orders = viewModel.getOrdersForTable(tableId);

        if (viewModel.isLoading) {
          return const CircularProgressIndicator();
        }

        if (viewModel.error != null) {
          return Text("Xatolik: ${viewModel.error}");
        }

        if (orders.isEmpty) {
          return SizedBox(
            height: isDesktop ? 300 : isTablet ? 200 : 100,
            child: Center(
              child: Image.asset('assets/icons/empty_order.png',height: isDesktop ? 64 :isTablet ? 48 : 40),
            ),
          );
        }

        return Column(
          children: orders.map((OrderModel order) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "• ${order.product?.name}",
                  style: const TextStyle(fontSize: 14),
                ),
                Text("${order.quantity} x ${order.product?.price ?? 0} so‘m"),
              ],
            );
          }).toList(),
        );
      },
    );
  }
}
