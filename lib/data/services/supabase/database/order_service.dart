import 'package:timerflow/exports.dart';

class OrderService {
  final _client = Supabase.instance.client;
  final String _tableName = 'orders';

  Future<OrderModel?> addOrder(OrderModel order) async {
    try {
      await _client.from(_tableName).insert(order.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<List<OrderModel>> getOrdersByTableId(String tableId) async {
    try {
      final response = await _client
          .from('orders')
          .select('*, products(*)') // 👈 JOIN: product_id -> products.id
          .eq('table_id', tableId)
          .order('created_at', ascending: false);

      final data = response as List<dynamic>;

      return data.map((json) {
        // debugPrint('Order JSON: $json'); // 👀 DEBUG
        return OrderModel.fromJson(json);
      }).toList();
    } catch (e) {
      debugPrint("OrderService.getOrdersByTableId error: $e");
      throw "OrderService.getOrdersByTableId error: $e";
    }
  }
}
