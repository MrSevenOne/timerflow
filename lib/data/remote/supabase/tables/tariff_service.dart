
import 'package:timerflow/data/repository/tables/tariff_repository.dart';
import 'package:timerflow/models/tariff_model.dart';

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
