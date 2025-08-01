import 'package:timerflow/exports.dart';

class OrderViewModel extends ChangeNotifier {
  final OrderService _service = OrderService();

  final Map<String, List<OrderModel>> _ordersMap = {};
  Map<String, List<OrderModel>> get ordersMap => _ordersMap;

  bool isLoading = false;
  String? error;

  Future<void> fetchOrdersByTableId(String tableId) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final orders = await _service.getOrdersByTableId(tableId);
      _ordersMap[tableId] = orders;
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  List<OrderModel> getOrdersForTable(String tableId) {
    return _ordersMap[tableId] ?? [];
  }

Future<void> addOrder(OrderModel order) async {
  try {
    final productService = ProductService();

    // Mahsulot sonini kamaytirish
    await productService.updateAmount(
      productId: order.productId,
      orderedQuantity: order.quantity,
    );

    // Orderni qo‘shish
    await _service.addOrder(order);

    final tableId = order.tableId;
    if (tableId != null) {
      _ordersMap.putIfAbsent(tableId, () => []);
      _ordersMap[tableId]!.add(order);
    }

    notifyListeners();
  } catch (e) {
    error = e.toString();
    rethrow;
  }
}


  // viewmodel/order_viewmodel.dart
double calculateTotalAmountForTable(String tableId, [int tablePriceSoFar = 0]) {
  final tableOrders = ordersMap[tableId] ?? [];

  final totalOrderPrice = tableOrders.fold<double>(0, (sum, order) {
    final price = order.product?.price ?? 0;
    return sum + (order.quantity * price);
  });

  return totalOrderPrice + tablePriceSoFar;
}



}
