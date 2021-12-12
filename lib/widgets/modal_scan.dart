import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:vaccpass/widgets/scan_location.dart';
import 'package:vaccpass/core/util/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaccpass/widgets/scan_vaccine.dart';



class ModalScan extends StatelessWidget {
  const ModalScan({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 5, left: 16, right: 16),
            child: Text('type_scan'.tr,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          ListTile(
            title: Text('scan_vaccine'.tr,
              style: const TextStyle(
                fontSize: 16,
                color: primaryColor,
              ),
            ),
            leading: const Icon(MdiIcons.qrcodeScan,
              color: primaryColor,
            ),
            onTap: () async {
              Navigator.of(context).pop();
              Get.to(() => const ScanVaccine());
            }
          ),
          ListTile(
            title: Text('scan_locations'.tr,
              style: const TextStyle(
                fontSize: 16,
                color: primaryColor,
              ),
            ),
            leading: const Icon(MdiIcons.selectMarker,
              color: primaryColor,
            ),
            onTap: () async {
              Navigator.of(context).pop();
              Get.to(() => const ScanLocation());
            }
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 45.0,
              child: Material(
                borderRadius: BorderRadius.circular(8.0),
                shadowColor: primaryColor,
                color: primaryColor,
                elevation: 0,
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Center(
                    child: Text('cancel'.tr,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
