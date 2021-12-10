import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:vaccpass/core/ui/responsive_safe_area.dart';
import 'package:vaccpass/core/util/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:vaccpass/pages/scan_location_page.dart';
import 'package:vaccpass/pages/scan_vaccine_page.dart';
import 'history_scan_page.dart';
import 'package:get/get.dart';
import 'info_page.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  Future<bool> _onWillPop(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 16, horizontal: 8,
          ),
          color: primaryColor,
          child: Text("app_name".tr,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        content: Text('exit_app'.tr,
          style: const TextStyle(
            color: taigaColor,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('cancel'.tr,
              style: const TextStyle(
                color: taigaColor,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('exit'.tr,
              style: const TextStyle(
                color: taigaColor,
              ),
            ),
          ),
        ],
      ),
    )??false;
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSafeArea(
      builder: (context) => WillPopScope(
        onWillPop: () => _onWillPop(context),
        child: Scaffold(
          appBar: AppBar(
            title: Text('app_name'.tr,
              style: GoogleFonts.lato()
            ),
            actions: [
              IconButton(
                icon: const Icon(MdiIcons.information,
                  color: Colors.white,
                ),
                onPressed: () => Get.to(() => const InfoPage()),
              )
            ],
          ),
          body: Container(
            decoration: BoxDecoration(
              color: const Color(0xff7c94b6),
              image: DecorationImage(
                fit: BoxFit.fitHeight,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3),
                  BlendMode.dstATop,
                ),
                image: const AssetImage(
                  'assets/images/bg.png',
                ),
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Material(
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () => Get.to(() => const VaccineHistory()),
                        child: SizedBox(
                          width: Get.width - 50,
                          height: Get.height/5.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/covid-passport.png',
                                color: primaryColor,
                                height: Get.height/8.5,
                              ),
                              const SizedBox(height: 6),
                              Text('DISPLAY PASSPORT',
                                style: GoogleFonts.lato(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                )
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8,),
                    Material(
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () => Get.to(() => const ScanLocationPage()),
                        child: SizedBox(
                          width: Get.width - 50,
                          height: Get.height/5.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/qr-code.png',
                                color: Colors.yellow,
                                height: Get.height/8.5,
                              ),
                              const SizedBox(height: 6),
                              Text('SCAN LOCATIONS',
                                style: GoogleFonts.lato(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                )
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8,),
                    Material(
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () => Get.to(() => const ScanVaccinePage()),
                        child: SizedBox(
                          width: Get.width - 50,
                          height: Get.height/5.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/path.png',
                                color: Colors.yellow,
                                height: Get.height/8.5,
                              ),
                              const SizedBox(height: 6),
                              Text('SCAN PASSPORT',
                                style: GoogleFonts.lato(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                )
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8,),
                    Material(
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () => Get.to(() => const LocationsHistory()),
                        child: SizedBox(
                          width: Get.width - 50,
                          height: Get.height/5.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/location.png',
                                color: primaryColor,
                                height: Get.height/8.5,
                              ),
                              const SizedBox(height: 6),
                              Text('DISPLAY LOCATIONS',
                                style: GoogleFonts.lato(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                )
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
