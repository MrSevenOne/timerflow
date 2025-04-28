import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/%20presentation/providers/bar_viewmodel.dart';

class BarPage extends StatelessWidget {
  const BarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bar Items')),
      body: Consumer<BarViewModel>(
        builder: (context, viewModel, _) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.error != null) {
            return Center(child: Text('Error: ${viewModel.error}'));
          }

          final bars = viewModel.bars;

          return ListView.builder(
            itemCount: bars.length,
            itemBuilder: (context, index) {
              final bar = bars[index];
              return ListTile(
                title: Text('Bar #${bar.id}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Drink: ${bar.drink?.name ?? 'N/A'} (${bar.drink?.price ?? 0} so\'m)'),
                    Text('Food: ${bar.food?.name ?? 'N/A'} (${bar.food?.price ?? 0} so\'m)'),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => viewModel.deleteBar(bar.id!),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // showDialog for adding new bar could be implemented here
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
