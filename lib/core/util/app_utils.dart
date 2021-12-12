import 'package:vaccpass/core/database/app_database.dart';
import 'package:vaccpass/covid_pass_model.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:io';


abstract class AppUtils extends ChangeNotifier {

  Future<void> saveScanQrcode(CovidPassModel pass, String? code);
  Future<void> clearHistory();
  Future<void> formatScanLocation(String? code);
  Future<void> convertFileToBase64(ScanEntity entity, File file);
  Uint8List convertImageBase64(ScanEntity entity);
  Future<bool> verificationCode(String currentText);
  Future<bool> checkPinCode();
  Future<void> createPinCode(String pinCode);
  Future<void> activateDeactivatePin(PinEntity? entity, bool val);
}
