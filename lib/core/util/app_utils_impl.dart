import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaccpass/core/database/app_database.dart';
import 'package:vaccpass/core/models/tracer_model.dart';
import 'package:vaccpass/core/error/failures.dart';
import 'package:vaccpass/covid_pass_model.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'dart:typed_data';
import 'app_utils.dart';
import 'dart:convert';
import 'keys.dart';
import 'dart:io';



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
  Future<void> saveScanQrcode(CovidPassModel pass, String? code) async {
    if (code != null) {
      final id = '${pass.givenName}${pass.familyName}';
      final entity = ScanEntity(id: id,
        familyName: pass.familyName??'',
        givenName:  pass.givenName??'',
        date: DateTime.now(),
        dob: pass.dob,
        encoded: code,
      );
      await database.scanEntitysDao.insertScanEntity(entity);
    }
  }


  @override
  Future<void> clearHistory() async {
    await database.delete(database.scanEntitys).go();
    await database.delete(database.tracerEntitys).go();
  }

  @override
  Future<void> formatScanLocation(String? code) async {
    try {
      if (code != null) {
        Codec<String, String> stringToBase64 = utf8.fuse(base64);
        final encoded = code.replaceAll('NZCOVIDTRACER:', '');
        String decoded = stringToBase64.decode(encoded);
        logger.i('decoded: $decoded');
        final model = tracerModelFromJson(decoded, code);
        if (decoded != null && model != null) {
          logger.i(model.toJsonModel());
          await database.tracerEntitysDao.insertTracerEntity(model);
        }
      }
    } catch(e) {
      logger.e(e);
      throw const NoDataFailure();
    }
  }

  Future<void> convertFileToBase64(ScanEntity entity, File file) async {
    try{
      Uint8List audioByte = await _readFileByte(file.path);
      String img = base64.encode(audioByte);
      await database.scanEntitysDao.updateScanImage(id: entity.id, imageId: img);
    } catch (e) {
      logger.e(e);
    }
  }

  Future<Uint8List> _readFileByte(String filePath) async {
    Uri myUri = Uri.parse(filePath);
    File audioFile = File.fromUri(myUri);
    Uint8List bytes = await audioFile.readAsBytes();
    // return Uint8List.fromList(bytes);
    return bytes;
  }

  Uint8List convertImageBase64(ScanEntity entity) {
    final img = entity.imageId??'';
    return const Base64Decoder().convert(img);
  }

  @override
  Future<bool> verificationCode(String currentText) async {
    final hasCode = await database.pinEntitysDao.verificationCode(currentText);
    return (hasCode != null);
  }

  @override
  Future<bool> checkPinCode() async {
    final hasCode = await database.pinEntitysDao.getPinCode(Keys.pinCodeId);
    return (hasCode != null && hasCode.active);
  }

  @override
  Future<void> createPinCode(String pinCode) async {
    final pin = PinEntity(
      id: Keys.pinCodeId,
      code: pinCode,
      active: true,
    );
    await database.pinEntitysDao.insertPinEntity(pin);
  }

  @override
  Future<void> activateDeactivatePin(PinEntity? entity, bool val) async {
    if (entity != null) {
      await database.pinEntitysDao.updatePinCode(id: entity.id, active: val);
    }
  }
}