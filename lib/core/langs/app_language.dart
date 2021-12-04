import 'package:vaccpass/core/usecases/preference_utils.dart';
import 'package:vaccpass/core/util/keys.dart';
import 'package:get/get.dart';


class AppLanguage extends GetxController {

  @override
  void onInit() {
    super.onInit();
  }

  void saveLanguage(String lang) async {
    await PreferenceUtils.setString(Keys.locale, lang);
    update();
  }
}