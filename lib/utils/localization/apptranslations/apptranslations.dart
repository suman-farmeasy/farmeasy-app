import 'package:farm_easy/utils/localization/apptranslations/englishwords.dart';
import 'package:farm_easy/utils/localization/apptranslations/hindiwords.dart';
import 'package:farm_easy/utils/localization/apptranslations/punjabiwords.dart';
import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys =>
      {'en': englishWords, 'hi': hindiWords, 'pa': punjabiWords};
}
