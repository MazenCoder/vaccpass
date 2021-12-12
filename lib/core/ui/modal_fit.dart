import 'package:vaccpass/core/database/app_database.dart';
import 'package:vaccpass/core/usecases/constants.dart';
import 'package:vaccpass/core/util/constants.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';



class ModalFit extends StatelessWidget {
  final ScanEntity entity;
  const ModalFit({required this.entity, Key? key}) : super(key: key);

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
            child: Text('add_license_or_id'.tr,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
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
              Navigator.of(context).pop();
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
                  await appUtils.convertFileToBase64(entity, croppedFile);
                }
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
              Navigator.of(context).pop();
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
                  await appUtils.convertFileToBase64(entity, croppedFile);
                }
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
