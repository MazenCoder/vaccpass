import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaccpass/core/database/app_database.dart';
import 'package:vaccpass/core/models/tracer_model.dart';
import 'package:vaccpass/covid_pass.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'app_utils.dart';
import 'dart:convert';



class AppUtilsImpl extends AppUtils {

  final SharedPreferences preferences;
  static var logger = Logger();
  final AppDatabase database;
  final http.Client client;

  AppUtilsImpl({
    required this.preferences,
    required this.client,
    required this.database});

  @override
  Future<void> saveScanQrcode(CovidPass pass) async {
    final id = '${pass.givenName}${pass.familyName}';
    final entity = ScanEntity(id: id,
      familyName: pass.familyName??'',
      givenName:  pass.givenName??'',
      dob: pass.dob,
    );
    await database.scanEntitysDao.insertScanEntity(entity);
  }


  @override
  Future<void> clearHistory() async {
    await database.delete(database.scanEntitys).go();
  }

  @override
  Future<void> formatCode(String? code) async {
    try {
      if (code != null) {
        Codec<String, String> stringToBase64 = utf8.fuse(base64);
        final encoded = code.replaceAll('NZCOVIDTRACER:', '');
        String decoded = stringToBase64.decode(encoded);
        final model = tracerModelFromJson(decoded, code);
        logger.i(model.toJsonModel());
        await database.tracerEntitysDao.insertTracerEntity(model);
      }
    } catch(e) {
      logger.e(e);
    }
  }
}