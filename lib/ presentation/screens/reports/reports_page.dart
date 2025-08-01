import 'package:timerflow/exports.dart';
import 'package:timerflow/utils/responsive_wrap.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hisoblar")),
      body: ResponsiveWrap(
        spacing: 16,
        children: [
          ReportItemWidget(
            imageUrl: 'payment.png',
            title: "To'lovlar Tarixi",
            onTap: () => Navigator.pushNamed(context, AppRoutes.paymentreport),
          ),
          ReportItemWidget(
            imageUrl: 'table_report.png',
            title: "Stollar Tarixi",
            onTap: () => Navigator.pushNamed(context, AppRoutes.tableReport),
          ),
          ReportItemWidget(
            imageUrl: 'bar.png',
            title: "Bar Tarixi",
            onTap: () => Navigator.pushNamed(context, AppRoutes.barReport),
          ),
        ],
      ),
    );
  }
}


class ReportItemWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final VoidCallback onTap;

  const ReportItemWidget({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: mainColor,
      borderRadius: BorderRadius.circular(12.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            children: [
              Image.asset("assets/icons/$imageUrl", height: 32.0),
              const SizedBox(width: 24.0),
              Flexible(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

