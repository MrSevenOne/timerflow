import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timerflow/domain/models/tarif_model.dart';

class TariffService {
  final supabase = Supabase.instance.client;
  final String tableName = 'tariffs';

  Future<List<TariffModel>> getTariffs() async {
    final response = await supabase
          .from(tableName)
          .select()
          .order('created_at', ascending: true);

      final data = response as List<dynamic>;
      return data.map((item) => TariffModel.fromJson(item)).toList();
  }
}
