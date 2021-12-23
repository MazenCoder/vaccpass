import 'package:vaccpass/core/database/app_database.dart';
import 'package:vaccpass/covid_pass_model.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:io';


abstract class AppUtils extends ChangeNotifier {

  Future<bool> saveScanQrcode(VaccineEntity? model, CovidPassModel pass, String? code);
  Future<void> clearHistory();
  Future<void> formatScanLocation(String? code);
  Future<void> convertFileToBase64(VaccineEntity entity, File file);
  Uint8List convertImageBase64(String? image);
  Future<bool> verificationCode(String currentText);
  Future<bool> checkPinCode();
  Future<void> createPinCode(String pinCode);
  Future<void> activateDeactivatePin(PinEntity? entity, bool val);
  Future<void> saveFilePassport(BuildContext context, File croppedFile);
  Future<void> saveFileLocation(BuildContext context, File croppedFile);
  Future<void> editVaccine({required BuildContext context,
    required VaccineEntity model, required bool deleteEncodedQr,
    required bool deletePhotoQr, required bool deletePhotoID});
  Future<void> editGivenNameVaccine({required BuildContext context,
    required VaccineEntity model, required String name});
  Future<void> editVaccineFilePassport(BuildContext context, VaccineEntity model, File croppedFile);
}
