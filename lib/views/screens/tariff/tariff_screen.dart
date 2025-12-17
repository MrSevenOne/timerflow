import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timerflow/models/user_tariff_model.dart';
import 'package:timerflow/presentation/viewmodel/service/table/tariff_viewmodel.dart';
import 'package:timerflow/presentation/viewmodel/service/table/user_tariff_viewmodel.dart';
import 'package:timerflow/routing/app_router.dart';
import 'package:timerflow/views/screens/tariff/widget/tariff_card.dart';
import 'package:timerflow/utils/extension/responsive_extension.dart';

class TariffScreen extends StatelessWidget {
  const TariffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<TariffViewModel>();

    // Load tariffs only once after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!vm.isLoading && vm.tariffs.isEmpty) {
        vm.fetchTariffs();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Tariff"),
        centerTitle: true,
      ),
      body: _TariffResponsive(vm: vm),
      // TariffScreen-dagi floatingActionButton onPressed
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (vm.selectedTariff == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please select a tariff first')),
            );
            return;
          }

          final userId = Supabase.instance.client.auth.currentUser?.id;
          if (userId == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('User not logged in')),
            );
            return;
          }

          final userTariffVm = context.read<UserTariffViewModel>();

          try {
            await userTariffVm.upsert(
              UserTariffModel(
                id: 0, // id UPSERT bilan ignore qilinadi
                createdAt: DateTime.now(),
                userId: userId,
                tariffId: vm.selectedTariff?.id ?? 0,
                status: true,
              ),
            );

            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content:
                      Text('${vm.selectedTariff!.name} selected successfully')),
            );
            Navigator.pushReplacementNamed(context, AppRouter.table);
          } catch (e) {
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to select tariff: $e')),
            );
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}

// ========================= RESPONSIVE WRAP GRID =========================
class _TariffResponsive extends StatelessWidget {
  final TariffViewModel vm;
  const _TariffResponsive({required this.vm});

  @override
  Widget build(BuildContext context) {
    if (vm.isLoading) return const Center(child: CircularProgressIndicator());
    if (vm.errorMessage != null) return Center(child: Text(vm.errorMessage!));
    if (vm.tariffs.isEmpty) {
      return const Center(child: Text("No tariffs found"));
    }

    // Screen width
    final screenWidth = MediaQuery.of(context).size.width;

    // Determine number of columns
    int crossAxisCount;
    if (screenWidth >= 1024) {
      crossAxisCount = 3; // Desktop
    } else if (screenWidth >= 600) {
      crossAxisCount = 2; // Tablet
    } else {
      crossAxisCount = 1; // Mobile
    }

    // Calculate item width
    double spacing =
        context.responsiveValue(mobile: 16, tablet: 24, desktop: 32);
    double itemWidth =
        (screenWidth - (crossAxisCount + 1) * spacing) / crossAxisCount;

    return SingleChildScrollView(
        padding: EdgeInsets.all(spacing),
        child: Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: vm.tariffs.asMap().entries.map((entry) {
            final index = entry.key;
            final tariff = entry.value;
            return GestureDetector(
              onTap: () {
                vm.setSelectedIndex(index); // ViewModel method
              },
              child: SizedBox(
                width: itemWidth,
                child: TariffCard(
                  tariff: tariff,
                  isSelected: vm.selectedIndex == index, // tanlangan element
                ),
              ),
            );
          }).toList(),
        ));
  }
}
