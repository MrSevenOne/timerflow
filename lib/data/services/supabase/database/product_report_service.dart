import 'package:timerflow/domain/models/product_report_model.dart';
import 'package:timerflow/exports.dart';

class ProductReportService extends BaseService{

  ProductReportService() : super('product_reports');

  Future<void> addProductReports(List<Map<String, dynamic>> data) async {
    try {
      if (data.isEmpty) return;

      await supabase.from(tableName).insert(data);
      debugPrint('✅ Product reports qo‘shildi');
    } catch (e) {
      debugPrint('❌ Product report insert xatolik: $e');
      rethrow;
    }
  }

  ///get bar report
  Future<List<ProductReportModel>> getAllProductReports() async {
  checkUserId();
  try {
    final response = await supabase
        .from(tableName) // tableName = 'product_reports'
        .select('*, products(*),tables(*)')
        .eq('user_id', currentUserId!)
        .order('created_at', ascending: false);

    return (response as List)
        .map((e) => ProductReportModel.fromJson(e))
        .toList();
  } catch (e) {
    debugPrint('ProductReport yuklanmadi: $e');
    throw Exception('ProductReport yuklanmadi: $e');
  }
}

  /// 🔄 Faqat `table_id` bo‘yicha orderlarni ko‘chirish va o‘chirish
  Future<void> moveOrdersByTableId({required String tableId}) async {
  try {
    await supabase.rpc(
      'move_orders_by_table_id',
      params: {'t_id': tableId},
    );

    debugPrint('✅ table_id = $tableId bo‘yicha orderlar ko‘chirildi va o‘chirildi');
  } catch (e) {
    debugPrint('❌ moveOrdersByTableId xatolik: $e');
    rethrow;
  }
}

}
