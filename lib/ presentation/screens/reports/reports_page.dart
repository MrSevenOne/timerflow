import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timerflow/config/constant/app_constant.dart';
import 'package:timerflow/routers/app_routers.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('reports'.tr),
      ),
      body: Padding(
        padding:  EdgeInsets.all(AppConstant.padding/2),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: Text(
                  'table_title'.tr,
                  style: GoogleFonts.pridi(textStyle: theme.textTheme.titleLarge,),
                ),
                trailing: Icon(Icons.navigate_next),
                onTap: () => Navigator.pushNamed(context, AppRoutes.tableReport),
              ),
            ),
            Card(
              child: ListTile(
                title: Text(
                  'bar_title'.tr,
                  style: GoogleFonts.pridi(textStyle: theme.textTheme.titleLarge,),
                ),
                trailing: Icon(Icons.navigate_next),
                onTap: () => Navigator.pushNamed(context, AppRoutes.barReport),
              ),
            ),
            Card(
              child: ListTile(
                title: Text(
                  'payment_title'.tr,
                  style: GoogleFonts.pridi(textStyle: theme.textTheme.titleLarge,),
                ),
                trailing: Icon(Icons.navigate_next),
                onTap: () => Navigator.pushNamed(context, AppRoutes.paymentreport),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
