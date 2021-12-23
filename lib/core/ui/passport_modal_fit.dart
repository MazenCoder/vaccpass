import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:vaccpass/core/usecases/constants.dart';
import 'package:vaccpass/widgets/scan_vaccine.dart';
import 'package:vaccpass/core/util/constants.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';



class PassportModalFit extends StatelessWidget {
  const PassportModalFit({Key? key}) : super(key: key);

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
            child: Text('add_take_library'.tr,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),

          /*
          ListTile(
            title: Text('scan_qrcode'.tr,
              style: const TextStyle(
                fontSize: 16,
                color: primaryColor,
              ),
            ),
            leading: const Icon(MdiIcons.qrcodeScan,
              color: primaryColor,
            ),
            onTap: () {
              Navigator.of(context).pop();
              Get.to(() => const ScanVaccine());
            }
          ),
          */

          ListTile(
            title: Text('photo_library'.tr,
              style: const TextStyle(
                fontSize: 16,
                color: primaryColor,
              ),
            ),
            leading: const Icon(Icons.photo,
              color: primaryColor,
            ),
            onTap: () async {
              final pickedFile = await picker.pickImage(source: ImageSource.gallery);
              if (pickedFile != null) {
                File? croppedFile = await ImageCropper.cropImage(
                    sourcePath: pickedFile.path,
                    aspectRatioPresets: [
                      CropAspectRatioPreset.square,
                      CropAspectRatioPreset.ratio3x2,
                      CropAspectRatioPreset.original,
                      CropAspectRatioPreset.ratio4x3,
                      CropAspectRatioPreset.ratio16x9
                    ],
                    androidUiSettings: AndroidUiSettings(
                        toolbarTitle: 'crop_rotate'.tr,
                        toolbarColor: primaryColor,
                        toolbarWidgetColor: Colors.white,
                        initAspectRatio: CropAspectRatioPreset.original,
                        lockAspectRatio: false),
                    iosUiSettings: const IOSUiSettings(
                      minimumAspectRatio: 1.0,
                    )
                );
                if (croppedFile != null) {
                  await appUtils.saveFilePassport(context, croppedFile);
                }
                Navigator.of(context).pop();
              }
            }
          ),
          ListTile(
            title: Text('take_photo'.tr,
              style: const TextStyle(
                fontSize: 16,
                color: primaryColor,
                fontFamily: 'SFPro-Regular',
              ),
            ),
            leading: const Icon(Icons.camera_alt,
              color: primaryColor,
            ),
            onTap: () async {
              final pickedFile = await picker.pickImage(source: ImageSource.camera);
              if (pickedFile != null) {
                File? croppedFile = await ImageCropper.cropImage(
                    sourcePath: pickedFile.path,
                    aspectRatioPresets: [
                      CropAspectRatioPreset.square,
                      CropAspectRatioPreset.ratio3x2,
                      CropAspectRatioPreset.original,
                      CropAspectRatioPreset.ratio4x3,
                      CropAspectRatioPreset.ratio16x9
                    ],
                    androidUiSettings: AndroidUiSettings(
                        toolbarTitle: 'crop_rotate'.tr,
                        toolbarColor: taigaColor,
                        toolbarWidgetColor: Colors.white,
                        initAspectRatio: CropAspectRatioPreset.original,
                        lockAspectRatio: false),
                    iosUiSettings: const IOSUiSettings(
                      minimumAspectRatio: 1.0,
                    )
                );
                if (croppedFile != null) {
                  await appUtils.saveFilePassport(context, croppedFile);
                }
                Navigator.of(context).pop();
              }
            }
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 45.0,
              child: Material(
                borderRadius: BorderRadius.circular(8.0),
                shadowColor: primaryColor,
                color: taigaColor,
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
