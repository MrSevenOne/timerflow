// lib/data/services/product_service.dart
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timerflow/domain/models/products_model.dart';

class ProductService {
  final _client = Supabase.instance.client;
  final String tableName = 'products';

  Future<List<ProductModel>> fetchProducts() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) throw Exception("User not logged in");

    final response = await _client
        .from(tableName)
        .select()
        .eq('user_id', userId)
        .order('name');

    return (response as List)
        .map((item) => ProductModel.fromJson(item))
        .toList();
  }

  Future<void> addProduct(ProductModel product) async {
    await _client.from(tableName).insert(product.toJson());
  }

  Future<void> updateProduct(ProductModel product) async {
    if (product.id == null) {
      throw Exception("Product ID is null");
    }

    await _client
        .from(tableName)
        .update(product.toJson())
        .eq('id', product.id as Object);
  }

  Future<void> deleteProduct(String id) async {
    await _client.from(tableName).delete().eq('id', id);
  }

  Future<void> updateAmount({
  required String productId,
  required int orderedQuantity,
}) async {
  final response = await _client
      .from(tableName)
      .select('amount')
      .eq('id', productId)
      .single();

  final int currentAmount = response['amount'];

  if (orderedQuantity > currentAmount) {
    throw Exception('Yetarli miqdor mavjud emas');
  }

  final int newAmount = currentAmount - orderedQuantity;

  await _client
      .from(tableName)
      .update({'amount': newAmount})
      .eq('id', productId);
}

}
