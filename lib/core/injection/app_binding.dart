import 'package:vaccpass/core/network/network_info.dart';
import 'package:get/get.dart';


class AppBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<NetworkInfo>(() => NetworkInfo());

    // Get.putAsync<SharedPreferences>(() async {
    //   final prefs = await SharedPreferences.getInstance();
    //   return prefs;
    // }, permanent: true);
    //
    // Get.putAsync<AppDatabase>(() async {
    //   final db = AppDatabase.instance;
    //   return db;
    // }, permanent: true);
  }

}