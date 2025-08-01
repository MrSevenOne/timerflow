import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/%20presentation/providers/order_viewmodel.dart';
import 'package:timerflow/%20presentation/providers/table_provider.dart';
import 'package:timerflow/%20presentation/tables/widget/bar_order_list.dart';
import 'package:timerflow/%20presentation/tables/widget/product_add.dart';
import 'package:timerflow/config/constant/app_constant.dart';
import 'package:timerflow/config/theme/ligth_theme.dart';
import 'package:timerflow/domain/models/table_model.dart';
import 'package:timerflow/utils/formatter/date_formatter.dart';
import 'package:timerflow/utils/formatter/number_formatted.dart';

class TableItems extends StatefulWidget {
  final TableModel table;
  const TableItems({super.key, required this.table});

  @override
  State<TableItems> createState() => _TableItemsState();
}

class _TableItemsState extends State<TableItems> {
  bool _expanded = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted && widget.table.status == 'busy') {
        setState(() {}); // duration yangilanishi uchun
      }
    });

    // Sahifa yuklanganda orderlarni olish
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final table = widget.table;
      if (table.updatedAt != null) {
        context.read<OrderViewModel>().fetchOrdersByTableId(table.id!);
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isBusy = widget.table.status == 'busy';
    

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isBusy ? theme.colorScheme.error : mainColor,
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: AppConstant.padding / 3),
            child: ListTile(
              leading: CircleAvatar(
                radius: 14,
                backgroundColor: isBusy ? theme.colorScheme.error : mainColor,
                child: Text(
                  '${widget.table.number}',
                  style: theme.textTheme.titleMedium!.copyWith(
                    color: theme.scaffoldBackgroundColor,
                  ),
                ),
              ),
              title: Text(
                widget.table.name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              subtitle: Text("Turi: ${widget.table.type}"),
              trailing: GestureDetector(
                child: isBusy
                    ? Image.asset('assets/icons/order.png', height: 32)
                    : Image.asset('assets/icons/begin.png',height: 32,width: 32,),
                onTap: () async {
                  if (isBusy) {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductList(tableId: widget.table.id!),
                      ),
                    );
    
                    context
                        .read<OrderViewModel>()
                        .fetchOrdersByTableId(widget.table.id!);
                  } else {
                    context
                        .read<TableProvider>()
                        .startTable(tableId: widget.table.id ?? '');
                  }
                },
              ),
              onTap: () {
                if (isBusy) {
                  setState(() => _expanded = !_expanded);
                }
              },
            ),
          ),
          if (_expanded && isBusy)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _tableAbout("Narxi:", widget.table.formattedPricePerHour),
                  _tableAbout(
                      "Boshlangan vaqt:", widget.table.formattedStartTime),
                  _tableAbout("O'tgan vaqt:", widget.table.liveDuration),
                  _tableAbout(
                      "Stol narxi:", '${widget.table.formattedPrice} so‘m'),
                  const SizedBox(height: 8),
                   Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Bar buyurtmalari:",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: mainColor),
                    ),
                  ),
                  const SizedBox(height: 4),
                  /// Bar buyurtmalari
                  BarOrdersList(tableId: widget.table.id!),
                  const SizedBox(height: 8),
                  /// Jami narx
                  Selector<OrderViewModel, double>(
                    selector: (_, viewModel) =>
                        viewModel.calculateTotalAmountForTable(
                      widget.table.id!,
                      widget.table.priceSoFar,
                    ),
                    builder: (context, total, _) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Jami:",style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
          ),
        ),
                           Text(
        "${NumberFormatter.price(total)} so‘m",
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
                ],
                      );
                    },
                  ),
                  TextButton(
                    onPressed: () async {
                      await context.read<TableProvider>().handleEndSession(
                            context: context,
                            table: widget.table,
                          );
                    },
                    child: Text(
                      "Tugatish",
                      style: TextStyle(
                        color: mainColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

Widget _tableAbout(String title, String description) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
      Text(
        description,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    ],
  );
}

extension TableModelExtensions on TableModel {
  String get liveDuration {
    if (updatedAt == null) return '00:00';
    final duration = DateTime.now().difference(updatedAt!);
    return DateFormatter.formatDuration(duration);
  }

  int get priceSoFar {
    if (updatedAt == null) return 0;
    final minutes = DateTime.now().difference(updatedAt!).inMinutes;
    final pricePerMinute = pricePerHour / 60;
    return (pricePerMinute * minutes).round();
  }

  String get formattedPrice => NumberFormatter.price(priceSoFar);
}
