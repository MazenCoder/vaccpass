import 'package:vaccpass/core/notifier/model_notifier.dart';
import 'package:vaccpass/core/util/app_utils_impl.dart';
import 'core/injection/injection_container.dart' as di;
import 'core/injection/injection_container.dart';
import 'core/usecases/preference_utils.dart';
import 'core/database/app_database.dart';
import 'package:flutter/foundation.dart';
import 'core/injection/app_binding.dart';
import 'package:provider/provider.dart';
import 'navigation/navigation_app.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'core/langs/translation.dart';
import 'core/util/constants.dart';
import 'core/ui/splash_app.dart';
import 'package:get/get.dart';
import 'core/util/keys.dart';



void main() async {
  var db = AppDatabase.instance;
  WidgetsFlutterBinding.ensureInitialized();
  await di.setup();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ModelNotifier()),
        ChangeNotifierProvider(create: (_) => AppUtilsImpl(
            database: sl(), preferences: sl(), client: sl(),
          ),
        ),
        Provider<AppDatabase>(
          create: (_) => db,
          dispose: (context, value) => value.close(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        initialBinding: AppBinding(),
        translations: Translation(),
        locale: Locale(PreferenceUtils.getString(Keys.locale, 'en')),
        fallbackLocale: const Locale('en'),
        debugShowCheckedModeBanner: false,
        title: 'VACCPASS',
        theme: ThemeData(
          primarySwatch: primaryColor,
          primaryColor: primaryColor,
          primaryTextTheme: const TextTheme(
            bodyText1: TextStyle(color: Colors.white,),
            bodyText2: TextStyle(color: Colors.white,),
          ),
          primaryIconTheme: const IconThemeData.fallback().copyWith(
            color: Colors.white,
          ),
        ),
        home: SplashApp(
          home: const NavigationApp(),
          type: AnimatedSplashType.StaticDuration,
          duration: 800,
        )
    );
  }
}