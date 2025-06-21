import 'package:timerflow/data/services/supabase/database/auth/tariff_service.dart';
import 'package:timerflow/domain/models/tarif_model.dart';

class TariffRepository {
  final TariffService tariffService;
  TariffRepository(this.tariffService);
  
//GET
  Future<List<TariffModel>> getTariffs() async => tariffService.getTariffs();
}
