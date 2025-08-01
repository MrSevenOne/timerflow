import 'package:responsive_framework/responsive_framework.dart';
import 'package:timerflow/exports.dart';

class TariffPage extends StatefulWidget {
  const TariffPage({super.key});

  @override
  State<TariffPage> createState() => _TariffPageState();
}

class _TariffPageState extends State<TariffPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TariffProvider>(context, listen: false).fetchTariffs());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final breakpoints = ResponsiveBreakpoints.of(context);
    final isMobile = breakpoints.isMobile;
    final isTablet = breakpoints.isTablet;
          

    return Scaffold(
      appBar: AppBar(title: const Text("Tariflar")),
      body: Consumer<TariffProvider>(
        builder: (context, vm, child) {
          if (vm.isLoading) return const Center(child: CircularProgressIndicator());
          if (vm.error != null) return Center(child: Text("Xatolik: ${vm.error}"));
          if (vm.tariffs.isEmpty) return const Center(child: Text("Tariflar topilmadi"));

  

          return Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              itemCount: vm.tariffs.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isMobile ? 1 : isTablet ? 2 : 3,
                mainAxisSpacing: isMobile ? 8 : isTablet ? 12 : 16,
                crossAxisSpacing: isMobile ? 8 : isTablet ? 12 : 16,
                childAspectRatio: 3 / 2,
              ),
              itemBuilder: (context, index) {
                final tariff = vm.tariffs[index];
                final isSelected = vm.selectedTariff?.id == tariff.id;

                return GestureDetector(
                  onTap: () => vm.selectTariff(tariff),
                  child: Card(
                    color: isSelected ? Colors.green[100] : null,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: isSelected
                          ? BorderSide(color: theme.primaryColor, width: 2)
                          : BorderSide.none,
                    ),
                    child: Padding(
                      padding:  EdgeInsets.all(AppConstant.padding),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            tariff.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              color: theme.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "${tariff.price} so'm",
                            textAlign: TextAlign.center,
                            style:  TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TariffInfo(title: "Stollar soni:", subtitle: tariff.maxTables),
                          TariffInfo(title: "Mahsulotlar soni:", subtitle: tariff.maxProducts),
                          TariffInfo(title: "Muddati (kun):", subtitle: tariff.durationDays),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: Consumer<TariffProvider>(
        builder: (context, vm, _) {
          return FloatingActionButton(
            onPressed: vm.selectedTariff == null
                ? null
                : () async {
                    try {
                      await vm.updateUserTariff();
                      if (context.mounted) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoutes.contactAdmin,
                          (route) => false,
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Xatolik: $e")),
                      );
                    }
                  },
            child: const Icon(Icons.check),
          );
        },
      ),
    );
  }
}

// Reusable info widget
Widget TariffInfo({required String title, required dynamic subtitle}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title, style: const TextStyle(fontSize: 14)),
      Text("$subtitle", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
    ],
  );
}
