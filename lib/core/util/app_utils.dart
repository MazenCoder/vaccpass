import 'package:vaccpass/covid_pass.dart';
import 'package:flutter/material.dart';
import 'dart:io';


abstract class AppUtils extends ChangeNotifier {

  Future<void> saveScanQrcode(CovidPass pass);


}
