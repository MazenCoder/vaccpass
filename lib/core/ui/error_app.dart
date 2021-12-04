import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:vaccpass/core/ui/responsive_safe_area.dart';
import 'package:vaccpass/navigation/navigation_app.dart';
import 'package:vaccpass/core/ui/splash_app.dart';
import 'package:vaccpass/core/util/img.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'loading_dialog.dart';



class ErrorApp extends StatelessWidget {
  final String? message;
  const ErrorApp({this.message, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveSafeArea(
      builder: (context) => Scaffold(
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(12),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('oops'.tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Image.asset(IMG.error, height: 220),
                  const SizedBox(height: 5,),
                  Text(message ?? 'something_wrong'.tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    icon: const Icon(MdiIcons.refresh),
                    label: Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 12),
                      child: Text('try_again'.tr),
                    ),
                    onPressed: () {
                      Get.offAll(() => SplashApp(
                        duration: 1000,
                        home: const NavigationApp(),
                        type: AnimatedSplashType.StaticDuration,
                      ));
                    },
                  ),
                  const SizedBox(height: 8,),
                  ElevatedButton.icon(
                    icon: const Icon(MdiIcons.alert),
                    label: Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 12),
                      child: Text('rest'.tr),
                    ),
                    onPressed: () async {
                      LoadingDialog.show();
                      // await appUtils.logOut();
                      LoadingDialog.hide();
                      Get.offAll(() => SplashApp(
                        duration: 1000,
                        home: const NavigationApp(),
                        type: AnimatedSplashType.StaticDuration,
                      ));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
