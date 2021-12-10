import 'package:vaccpass/core/notifier/model_notifier.dart';
import 'package:vaccpass/navigation/navigation_app.dart';
import 'package:package_info/package_info.dart';
import 'package:vaccpass/core/util/img.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

import 'package:vaccpass/pages/home_page.dart';



AnimatedSplashType? _runfor;
Function? _customFunction;
String? _imagePath;
int? _duration;
Widget? _home;


enum AnimatedSplashType { StaticDuration, BackgroundProcess }

Map<dynamic, Widget> _outputAndHome = {};

class SplashApp extends StatefulWidget {

  SplashApp({
    Key? key,
    required Widget home,
    required int duration,
    required AnimatedSplashType type,
  }) : super(key: key) {
    _home = home;
    _duration = duration;
    _runfor = type;
  }

  @override
  _SplashAppState createState() => _SplashAppState();
}

class _SplashAppState extends State<SplashApp>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    if (_duration! < 1000) _duration = 2000;
    _initAnimation();
    _navigator();
  }

  void _initAnimation() {
    try {
      _animationController = AnimationController(
          duration: const Duration(seconds: 5), vsync: this);
      final curvedAnimation = CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
        reverseCurve: Curves.easeOut,
      );

      _animation = Tween<double>(
          begin: 0, end: 2 * math.pi).animate(curvedAnimation)
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            _animationController.reverse();
          } else if (status == AnimationStatus.dismissed) {
            _animationController.forward();
          }}
        );
      _animationController.forward();
    } catch(e) {
      _animationController.dispose();
    }
  }

  _navigator() async {
    //! Version
    final packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    context.read<ModelNotifier>().setVersion(version);
    await Future.delayed(const Duration(seconds: 2));
    Get.offAll(() => const HomePage());
  }


  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 20.0),
            child: Image.asset(
              IMG.logo1,
              width: Get.width/3,
            ),
          ),
        )
      ),
    );
  }
}
