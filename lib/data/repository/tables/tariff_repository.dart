import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timerflow/models/tariff_model.dart';

class TariffRepository {
  final supabase = Supabase.instance.client;
  final String table = 'tariffs';

  // GET ALL
  Future<List<TariffModel>> getTariffs() async {
    final response = await supabase.from(table).select().order('created_at');

    return (response as List<dynamic>)
        .map((item) => TariffModel.fromJson(item))
        .toList();
  }

  // GET BY ID
  Future<TariffModel?> getTariffById(int id) async {
    final response =
        await supabase.from(table).select().eq('id', id).maybeSingle();

    if (response == null) return null;

    return TariffModel.fromJson(response);
  }

}
