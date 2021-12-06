import 'package:vaccpass/covid_pass_model.dart';
import 'package:flutter/material.dart';
import 'dart:io';


abstract class AppUtils extends ChangeNotifier {

  Future<void> saveScanQrcode(CovidPassModel pass, String? code);
  Future<void> clearHistory();
  Future<void> formatScanLocation(String? code);


}
