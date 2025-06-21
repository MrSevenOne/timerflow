import 'package:get/get.dart';
import 'en_us.dart';
import 'ru_ru.dart';
import 'uz_uz.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'uz_UZ': uzUz,
        'en_US': enUs,
        'ru_RU': ruRu,
      };
}
