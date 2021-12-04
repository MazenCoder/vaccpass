import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaccpass/core/database/app_database.dart';
import 'package:vaccpass/covid_pass.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'app_utils.dart';



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
}