import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:vaccpass/core/ui/location_modal_fit.dart';
import 'package:vaccpass/core/ui/responsive_safe_area.dart';
import 'package:vaccpass/core/cache/preference_utils.dart';
import 'package:vaccpass/core/ui/passport_modal_fit.dart';
import 'package:vaccpass/core/usecases/constants.dart';
import 'package:vaccpass/widgets/create_pin_code.dart';
import 'package:vaccpass/widgets/scan_location.dart';
import 'package:vaccpass/pages/locations_page.dart';
import 'package:vaccpass/core/util/constants.dart';
import 'package:vaccpass/pages/vaccine_page.dart';
import 'package:after_layout/after_layout.dart';
import 'package:vaccpass/core/util/keys.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'info_page.dart';




class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AfterLayoutMixin<HomePage>{

  Future showDialogPinCode(BuildContext context) async {
    try {
      return await CoolAlert.show(
          context: context,
          type: CoolAlertType.info,
          barrierDismissible: true,
          title: 'set_pin'.tr,
          text: 'prompted_enter_pin'.tr,
          confirmBtnText: 'ok'.tr,
          backgroundColor: primaryColor,
          confirmBtnColor: primaryColor,
          onConfirmBtnTap: () {
            Navigator.pop(context);
            Get.to(() => const CreatePinCode());
          }
      );
    } catch(e) {
      logger.e('$e');
    }
  }

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
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              // backgroundColor: Colors.white,
              title: Text('app_name'.tr,
                style: const TextStyle(
                  fontFamily: 'SansSerifFLF',
                  color: Colors.white,
                  // color: primaryColor
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    MdiIcons.information,
                    // color: primaryColor,
                    color: Colors.white,
                  ),
                  onPressed: () => Get.to(() => const InfoPage()),
                )
              ],
            ),
            backgroundColor: Colors.transparent,
            // backgroundColor: primaryColor,
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Material(
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () => Get.to(() => const VaccinePage()),
                        child: SizedBox(
                          width: Get.width - 50,
                          height: Get.height/5.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(MdiIcons.folderAccount,
                                color: primaryColor,
                                size: Get.height/8.5,
                              ),
                              // Image.asset('assets/images/identity-card.png',
                              //   color: primaryColor,
                              //   height: Get.height/8.5,
                              // ),
                              const SizedBox(height: 6),
                              Text('display_id_pass'.tr.toUpperCase(),
                                style: const TextStyle(
                                  fontFamily: 'SansSerifFLF',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
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
                        // onTap: () => Get.to(() => const ScanLocation()),
                        onTap: () => showMaterialModalBottomSheet(
                            expand: false, context: context,
                            backgroundColor: Colors.transparent,
                            builder: (context) => const LocationModalFit()),
                        child: SizedBox(
                          width: Get.width - 50,
                          height: Get.height/5.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(MdiIcons.cameraMarker,
                                size: Get.height/8.5,
                                color: primaryColor,
                              ),
                              // Image.asset('assets/images/add-image.png',
                              //   color: primaryColor,
                              //   // color: Colors.yellow,
                              //   height: Get.height/8.5,
                              // ),
                              const SizedBox(height: 6),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text('add_qr_code_photo_location'.tr.toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontFamily: 'SansSerifFLF',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),
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
                        // onTap: () => Get.to(() => const ScanVaccine()),
                        onTap: () => showMaterialModalBottomSheet(
                          expand: false, context: context,
                          backgroundColor: Colors.transparent,
                          builder: (context) => const PassportModalFit()),
                        child: SizedBox(
                          width: Get.width - 50,
                          height: Get.height/5.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(MdiIcons.cameraPlus,
                                size: Get.height/8.5,
                                color: primaryColor,
                              ),
                              // Image.asset('assets/images/add-photo.png',
                              //   color: primaryColor,
                              //   // color: Colors.yellow,
                              //   height: Get.height/8.5,
                              // ),
                              const SizedBox(height: 6),
                              Text('add_id_pass'.tr.toUpperCase(),
                              // const Text('SCAN /UPLOAD PASSPORT',
                                style: const TextStyle(
                                  fontFamily: 'SansSerifFLF',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
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
                        onTap: () => Get.to(() => const LocationsPage()),
                        child: SizedBox(
                          width: Get.width - 50,
                          height: Get.height/5.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(MdiIcons.folderMarker,
                                color: primaryColor,
                                size: Get.height/8.5,
                              ),
                              // Image.asset('assets/images/location.png',
                              //   color: primaryColor,
                              //   height: Get.height/8.5,
                              // ),
                              const SizedBox(height: 6),
                              Text('display_locations'.tr.toUpperCase(),
                                style: const TextStyle(
                                  fontFamily: 'SansSerifFLF',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
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

  @override
  void afterFirstLayout(BuildContext context) async {
    final check = PreferenceUtils.getBool(Keys.dialogPinCode, true);
    if (check) {
      await showDialogPinCode(context);
      PreferenceUtils.setBool(Keys.dialogPinCode, false);
    }
  }
}
