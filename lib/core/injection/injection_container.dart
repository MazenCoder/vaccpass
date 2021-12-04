import 'package:vaccpass/core/usecases/preference_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaccpass/core/database/app_database.dart';
import 'package:vaccpass/core/util/app_utils_impl.dart';
import 'package:vaccpass/core/usecases/constants.dart';
import 'package:vaccpass/core/util/app_utils.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';



final GetIt sl = GetIt.instance;

Future<void> setup() async {
  try {
    await init();
  } catch(e) {
    logger.e('error, setup: $e');
  }
}

///!  init
Future<void> init() async {
  try {

    //! External
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // sl.registerLazySingleton(() => DataConnectionChecker());
    sl.registerLazySingleton(() => sharedPreferences);
    sl.registerLazySingleton(() => http.Client());

    //! Database
    final db = AppDatabase.instance;
    sl.registerLazySingleton(() => db);

    //! Preference
    PreferenceUtils instance = await PreferenceUtils.init();
    sl.registerSingleton<PreferenceUtils>(instance);

    sl.registerSingleton<AppUtils>(AppUtilsImpl(preferences: sl(),
        client: sl(), database: sl()), signalsReady: true);

  } catch(e) {
    logger.e(e);
  }
}
