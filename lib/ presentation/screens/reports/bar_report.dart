import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timerflow/%20presentation/providers/drink/drink_report_viewmodel.dart';
import 'package:timerflow/%20presentation/providers/food/food_report_viewmodel.dart';
import 'package:timerflow/%20presentation/widgets/table_widget/table_report_info.dart';
import 'package:timerflow/config/constant/app_constant.dart';
import 'package:timerflow/config/theme/ligth_theme.dart';
import 'package:timerflow/utils/formatter/number_formatted.dart';

class BarReportPage extends StatefulWidget {
  const BarReportPage({super.key});

  @override
  State<BarReportPage> createState() => _BarReportPageState();
}

class _BarReportPageState extends State<BarReportPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  DateTimeRange? _selectedDateRange;

  @override
  void initState() {
    super.initState();
    final drinkVM = Provider.of<DrinkReportViewModel>(context, listen: false);
    final foodVM = Provider.of<FoodReportViewModel>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      drinkVM.fetchByUserId();
      foodVM.fetchByUserReportId();
    });

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<T> filterByDate<T>(
      List<T> reports, DateTimeRange? range, DateTime Function(T) getTime) {
    if (range == null) return reports;
    return reports.where((r) {
      final date = getTime(r);
      return date.isAfter(range.start) && date.isBefore(range.end);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final drinkVM = context.watch<DrinkReportViewModel>();
    final foodVM = context.watch<FoodReportViewModel>();

    final isLoading = drinkVM.isLoading || foodVM.isLoading;
    final hasError = drinkVM.error != null || foodVM.error != null;

    final filteredDrinkReports =
        filterByDate(drinkVM.reports, _selectedDateRange, (r) => r.createdAt!);
    final filteredFoodReports =
        filterByDate(foodVM.reports, _selectedDateRange, (r) => r.createdAt!);

    final totalDrinkSum = filteredDrinkReports.fold<int>(
      0,
      (prev, item) => prev + (item.drinkModel?.price ?? 0) * item.quantity,
    );

    final totalFoodSum = filteredFoodReports.fold<int>(
      0,
      (prev, item) => prev + (item.foodModel?.price ?? 0) * item.quantity,
    );

    return Scaffold(
      appBar: AppBar(
        title:  Text('report_bar'.tr),
        actions: [
          IconButton(
            icon: const Icon(Icons.date_range),
            onPressed: () async {
              final picked = await showDateRangePicker(
                context: context,
                firstDate: DateTime(2020),
                lastDate: DateTime(2100),
                initialDateRange: _selectedDateRange,
              );
              if (picked != null) {
                setState(() => _selectedDateRange = picked);
              }
            },
          )
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs:  [
            Tab(text: "report_drink".tr),
            Tab(text: "report_food".tr),
          ],
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : hasError
              ? Center(
                  child: Text(
                    drinkVM.error ?? foodVM.error ?? "Unknown error",
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              : TabBarView(
                  controller: _tabController,
                  children: [
                    // DRINK REPORTS TAB
                    filteredDrinkReports.isEmpty
                        ?  Center(child: Text("drink_empty".tr))
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  itemCount: filteredDrinkReports.length,
                                  itemBuilder: (context, index) {
                                    final report = filteredDrinkReports[index];
                                    if (report.drinkModel == null)
                                      return const SizedBox();
                                    final totalSum = NumberFormatter.price(
                                      report.quantity *
                                          report.drinkModel!.price,
                                    );
                                    return Card(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: AppConstant.padding,
                                          horizontal: AppConstant.padding,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              report.drinkModel!.name,
                                              style: GoogleFonts.pridi(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge,
                                              ),
                                            ),
                                            SizedBox(height: 4.h),
                                            TableReportInfoRow(
                                              title: 'price'.tr,
                                              value: report
                                                  .drinkModel!.formattedPrice,
                                            ),
                                            TableReportInfoRow(
                                              title: 'amount'.tr,
                                              value:
                                                  '${report.quantity} ${'piece'.tr}',
                                            ),
                                            TableReportInfoRow(
                                              title: 'total_sum',
                                              value: "$totalSum so'm",
                                            ),
                                            TableReportInfoRow(
                                              title: 'order_time'.tr,
                                              value: report.formattStartTime,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              TotalSum(context, totalDrinkSum),
                            ],
                          ),
                    // FOOD REPORTS TAB
                    filteredFoodReports.isEmpty
                        ?  Center(child: Text("food_empty".tr))
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  itemCount: filteredFoodReports.length,
                                  itemBuilder: (context, index) {
                                    final report = filteredFoodReports[index];
                                    if (report.foodModel == null)
                                      return const SizedBox();
                                    final totalSum = NumberFormatter.price(
                                      report.quantity * report.foodModel!.price,
                                    );
                                    return Card(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: AppConstant.padding,
                                          horizontal: AppConstant.padding / 2,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              report.foodModel!.name,
                                              style: GoogleFonts.pridi(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge,
                                              ),
                                            ),
                                            SizedBox(height: 4.h),
                                            TableReportInfoRow(
                                              title: 'price'.tr,
                                              value: report
                                                  .foodModel!.formattedPrice,
                                            ),
                                            TableReportInfoRow(
                                              title: 'amount'.tr,
                                              value:
                                                  '${report.quantity} ${'piece'.tr}',
                                            ),
                                            TableReportInfoRow(
                                              title: 'total_sum',
                                              value: "$totalSum so'm",
                                            ),
                                            TableReportInfoRow(
                                              title: 'order_time'.tr,
                                              value: report.formattStartTime,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                             TotalSum(context, totalFoodSum),
                            ],
                          ),
                  ],
                ),
    );
  }
}

Widget TotalSum(BuildContext context,dynamic total) {
  return Container(
    padding: EdgeInsets.only(bottom: 24, right: 24, left: 24, top: 12),
    decoration: BoxDecoration(
      color: mainColor,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'total_sum'.tr,
          style: GoogleFonts.pridi(
            textStyle: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Theme.of(context).scaffoldBackgroundColor),
          ),
        ),
        Text(
          "${NumberFormatter.price(total)} so'm",
          style: GoogleFonts.pridi(
            textStyle: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Theme.of(context).scaffoldBackgroundColor),
          ),
        ),
      ],
    ),
  );
}
