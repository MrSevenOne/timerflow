
import 'package:timerflow/models/tariff_model.dart';
import 'package:timerflow/repositories/tables/tariff_repository.dart';

class TariffService {
  final TariffRepository _repository = TariffRepository();

//GET TARIFFS
  Future<List<TariffModel>> fetchTariffs() async {
    return await _repository.getTariffs();
  }
//GET TARIFFFS BY ID
  Future<TariffModel?> fetchTariffById(int id) async {
    return await _repository.getTariffById(id);
  }

}
