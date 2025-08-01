import 'package:responsive_framework/responsive_framework.dart';
import 'package:timerflow/%20presentation/providers/order_viewmodel.dart';
import 'package:timerflow/exports.dart';

class ProductList extends StatefulWidget {
  final String tableId;

  const ProductList({super.key, required this.tableId});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final Map<String, int> _quantities = {}; // product.id -> quantity

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    Future.microtask(() {
      context.read<ProductViewModel>().fetchProducts();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buyurtma'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Ichimliklar'),
            Tab(text: 'Taomlar'),
          ],
        ),
      ),
      body: Consumer<ProductViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final drinks =
              viewModel.products.where((p) => p.type == 'drink').toList();
          final foods =
              viewModel.products.where((p) => p.type == 'food').toList();

          return TabBarView(
            controller: _tabController,
            children: [
              _buildProductGrid(drinks),
              _buildProductGrid(foods),
            ],
          );
        },
      ),
    );
  }

  Widget _buildProductGrid(List<ProductModel> products) {
    final breakpoints = ResponsiveBreakpoints.of(context);
    final isMobile = breakpoints.isMobile;
    final isTablet = breakpoints.isTablet;
    final isDesktop = breakpoints.isDesktop;
    final userId = UserManager.currentUserId!;

    double itemWidth;
    if (isMobile) {
      itemWidth = MediaQuery.of(context).size.width;
    } else if (isTablet) {
      itemWidth = MediaQuery.of(context).size.width / 2;
    } else {
      itemWidth = MediaQuery.of(context).size.width / 3;
    }

    if (products.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/empty-box.png',
              height: isDesktop ? 400 : isTablet ? 300 : 200,
            ),
            const SizedBox(height: 20),
            const Text(
              "Hozircha mahsulot mavjud emas",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: products.map((product) {
          final quantity = _quantities[product.id] ?? 0;

          return SizedBox(
            width: itemWidth - 16,
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.name,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    RowInfo("Narxi", "${product.price} so‘m"),
                    RowInfo("Mavjud", "${product.amount} dona"),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        IconButton(
                          onPressed: quantity > 0
                              ? () {
                                  setState(() {
                                    _quantities[product.id!] = quantity - 1;
                                  });
                                }
                              : null,
                          icon: const Icon(Icons.remove_circle_outline),
                        ),
                        Text('$quantity',
                            style: const TextStyle(fontSize: 16)),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _quantities[product.id!] = quantity + 1;
                            });
                          },
                          icon: const Icon(Icons.add_circle_outline),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: quantity > 0
                              ? () async {
                                  final order = OrderModel(
                                    userId: userId,
                                    productId: product.id!,
                                    tableId: widget.tableId,
                                    quantity: quantity,
                                    orderTime: DateTime.now().toLocal(),
                                    createdAt: DateTime.now().toLocal(),
                                  );
                                  await _handleAddOrder(order, context);
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green),
                          child: const Text("Qo‘shish"),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget RowInfo(String title, String subtitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        Text(subtitle, style: const TextStyle(fontSize: 14)),
      ],
    );
  }

  Future<void> _handleAddOrder(OrderModel order, BuildContext context) async {
    try {
      await context.read<OrderViewModel>().addOrder(order);
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString().replaceAll("Exception:", "").trim(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.red.shade600,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
}
