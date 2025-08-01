import 'package:timerflow/exports.dart';

class TariffService extends BaseService {
  TariffService() : super('tariffs');

  Future<List<TariffModel>> getAllTariffs() async {
    try {
      final response = await supabase.from(tableName).select();
      return (response as List).map((e) => TariffModel.fromJson(e)).toList();
    } catch (e) {
      debugPrint("Tariff yuklashdagi xato: $e");
      throw Exception('Tariflar yuklanmadi: $e');
    }
  }

  Future<TariffModel> getTariffById(String id) async {
    try {
      final response =
          await supabase.from(tableName).select().eq('id', id).single();
      return TariffModel.fromJson(response);
    } catch (e) {
      throw Exception('Tarif topilmadi: $e');
    }
  }
}
