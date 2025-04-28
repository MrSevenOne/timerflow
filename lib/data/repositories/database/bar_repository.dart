import 'package:timerflow/data/services/supabase/database/bar_service.dart';
import 'package:timerflow/domain/models/order_model.dart';

class BarRepository {
  final BarService _barService = BarService();

  Future<List<BarModel>> getBars() => _barService.fetchBars();

  Future<void> addBar(BarModel bar) => _barService.addBar(bar);

  Future<void> updateBar(BarModel bar) => _barService.updateBar(bar);

  Future<void> deleteBar(int id) => _barService.deleteBar(id);
}
