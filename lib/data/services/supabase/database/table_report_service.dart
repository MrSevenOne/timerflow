import 'package:timerflow/exports.dart';

class TableReportService extends BaseService {
  TableReportService() : super('table_reports');

  /// Barcha hisobotlarni olish (foydalanuvchi bo‘yicha)
  Future<List<TableReportModel>> getTableReports() async {
    checkUserId();

    try {
      final response = await supabase
    .from(tableName)
    .select('*, table:table_id(*)') 
    .eq('user_id', currentUserId!)
    .order('created_at', ascending: false);


      return (response as List)
          .map((e) => TableReportModel.fromJson(e))
          .toList();
    } catch (e) {
      debugPrint("getTableReports error: $e");
      throw Exception("Hisobotlar yuklanmadi: $e");
    }
  }

  /// Bitta stol bo‘yicha hisobotlar
  Future<List<TableReportModel>> getReportsByTableId(String tableId) async {
    checkUserId();

    try {
      final response = await supabase
          .from(tableName)
          .select()
          .eq('user_id', currentUserId!)
          .eq('table_id', tableId)
          .order('created_at', ascending: false);

      return (response as List)
          .map((e) => TableReportModel.fromJson(e))
          .toList();
    } catch (e) {
      debugPrint("getReportsByTableId error: $e");
      throw Exception("Stol bo‘yicha hisobotlar yuklanmadi: $e");
    }
  }

  /// Yangi hisobot qo‘shish va ID bilan qaytarish
  Future<TableReportModel> addReport(TableReportModel report) async {
    checkUserId();

    try {
      final response = await supabase
          .from(tableName)
          .insert(report.toJson())
          .select()
          .single();

      final model = TableReportModel.fromJson(response);
      debugPrint("✅ Table Report qo‘shildi: ${model.id}");
      return model;
    } catch (e) {
      debugPrint("❌ Table Report qo‘shilmadi: $e");
      throw Exception("Hisobot qo‘shilmadi: $e");
    }
  }

  /// Hisobotni o‘chirish
  Future<void> deleteReport(String id) async {
    checkUserId();

    try {
      await supabase
          .from(tableName)
          .delete()
          .eq('id', id)
          .eq('user_id', currentUserId!);
    } catch (e) {
      debugPrint("deleteReport error: $e");
      throw Exception("Hisobot o‘chirilmadi: $e");
    }
  }
}
