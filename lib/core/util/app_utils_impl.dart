import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaccpass/core/database/app_database.dart';
import 'package:vaccpass/core/models/tracer_model.dart';
import 'package:vaccpass/core/error/failures.dart';
import 'package:vaccpass/covid_pass_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';
import 'package:get/get.dart';
import 'flash_helper.dart';
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
  Future<bool> saveScanQrcode(VaccineEntity? model, CovidPassModel pass, String? code) async {
    try {
      if (model != null && code != null) {
        final entity = VaccineEntity(
          id: model.id,
          familyName: pass.familyName??'',
          givenName:  pass.givenName??'',
          imageId: model.imageId,
          imageVaccine: '',
          date: model.date,
          dob: pass.dob,
          encoded: code,
        );
        await database.vaccineEntitysDao.insertVaccine(entity);
        return true;
      } else if (code != null && model == null) {
        final id = '${pass.givenName}${pass.familyName}';
        final entity = VaccineEntity(id: id,
          familyName: pass.familyName??'',
          givenName:  pass.givenName??'',
          date: DateTime.now(),
          dob: pass.dob,
          encoded: code,
        );
        await database.vaccineEntitysDao.insertVaccine(entity);
        return true;
      }
      return false;
    } catch(e) {
      logger.e(e);
      return false;
    }
  }

  @override
  Future<void> saveFilePassport(BuildContext context, File croppedFile) async {
    try {
      logger.i('saved');
      final id = const Uuid().v4();
      // Uint8List audioByte = await _readFileByte(croppedFile.path);
      Uint8List? audioByte = await compressFile(croppedFile);
      String img = base64.encode(audioByte!);
      final entity = VaccineEntity(
        id: id, date: DateTime.now(),
        imageVaccine: img,
      );
      await database.vaccineEntitysDao.insertVaccine(entity);
      logger.i('saved 2');
      FlashHelper.successBar(
        context: context,
        title: 'Scan Passport',
        message: 'saved_success'.tr,
      );
    } catch(e) {
      logger.e(e);
      FlashHelper.errorBar(
        context: context,
        title: 'Scan Passport',
        message: 'something_wrong'.tr,
      );
    }
  }

  @override
  Future<void> saveFileLocation(BuildContext context, File croppedFile) async {
    try {
      logger.i('saved');
      final id = const Uuid().v4();
      // Uint8List audioByte = await _readFileByte(croppedFile.path);
      Uint8List? audioByte = await compressFile(croppedFile);
      String img = base64.encode(audioByte!);
      final entity = LocationEntity(
        gln: id, date: DateTime.now(),
        imageVaccine: img, adr: 'New Location',
        opn: 'New Location',
      );
      await database.locationEntitysDao.insertLocation(entity);
      logger.i('saved 2');
      FlashHelper.successBar(
        context: context,
        title: 'Location',
        message: 'saved_success'.tr,
      );
    } catch(e) {
      logger.e(e);
      FlashHelper.errorBar(
        context: context,
        title: 'Location',
        message: 'something_wrong'.tr,
      );
    }
  }


  @override
  Future<void> clearHistory() async {
    await database.delete(database.vaccineEntitys).go();
    await database.delete(database.locationEntitys).go();
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
          await database.locationEntitysDao.insertLocation(model);
        }
      }
    } catch(e) {
      logger.e(e);
      throw const NoDataFailure();
    }
  }

  @override
  Future<void> convertFileToBase64(VaccineEntity entity, File file) async {
    try{
      // Uint8List audioByte = await _readFileByte(file.path);
      Uint8List? audioByte = await compressFile(file);
      String img = base64.encode(audioByte!);
      // VaccineEntity(id: entity.id, imageId: img, );
      await database.vaccineEntitysDao.updateScanImage(id: entity.id, imageId: img);
    } catch (e) {
      logger.e(e);
    }
  }

  /*
  Future<Uint8List> _readFileByte(String filePath) async {
    Uri myUri = Uri.parse(filePath);
    File audioFile = File.fromUri(myUri);
    Uint8List bytes = await audioFile.readAsBytes();
    return Uint8List.fromList(bytes);
    // return bytes;
  }
  */

  Future<Uint8List?> compressFile(File file) async {
    var result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      // minWidth: 1300,
      // minHeight: 800,
      quality: 40,
      rotate: 0,
    );
    return result;
  }

  @override
  Uint8List convertImageBase64(String? img) {
    return const Base64Decoder().convert(img??'');
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

  @override
  Future<void> editVaccine({required BuildContext context,
  required VaccineEntity model, required bool deleteEncodedQr,
    required bool deletePhotoQr, required bool deletePhotoID}) async {
    if (deleteEncodedQr) {
      final checkConfirm = await confirmDelete(context, 'QR Code');
      if (checkConfirm) {
        final entity = VaccineEntity(
          id: model.id,
          imageVaccine: model.imageVaccine,
          familyName: model.familyName,
          givenName: model.givenName,
          imageId: model.imageId,
          date: model.date,
          dob: model.dob,
          encoded:  '',
        );
        await database.vaccineEntitysDao.updateVaccineById(id: model.id, entity: entity);
      }
    } else if (deletePhotoQr) {
      final checkConfirm = await confirmDelete(context, 'Photo Qr Code');
      if (checkConfirm) {
        final entity = VaccineEntity(
          id: model.id,
          familyName: model.familyName,
          givenName: model.givenName,
          encoded: model.encoded,
          imageId: model.imageId,
          date: model.date,
          dob: model.dob,
          imageVaccine: '',
        );
        await database.vaccineEntitysDao.updateVaccineById(id: model.id, entity: entity);
      }
    } else if (deletePhotoID) {
      final checkConfirm = await confirmDelete(context, 'Photo ID');
      if (checkConfirm) {
        final entity = VaccineEntity(
          id: model.id,
          imageVaccine: model.imageVaccine,
          familyName: model.familyName,
          givenName: model.givenName,
          encoded: model.encoded,
          date: model.date,
          dob: model.dob,
          imageId: '',
        );
        await database.vaccineEntitysDao.updateVaccineById(id: model.id, entity: entity);
      }
    }
  }

  Future<bool> confirmDelete(BuildContext context, String content) async {
    return await showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text('delete'.tr,
          style: const TextStyle(
            fontFamily: 'SansSerifFLF',
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text('confirm_delete_photo'.tr,
        // content: Text('Are you sure you want to delete this $content',
          style: const TextStyle(
            fontFamily: 'SansSerifFLF',
            fontWeight: FontWeight.normal,
          ),
        ),
        actions: [
          TextButton(
            child: Text('delete'.tr),
            onPressed: () => Navigator.pop(context, true),
          ),

          TextButton(
            child: Text('cancel'.tr),
            onPressed: () => Navigator.pop(context, false),
          ),
        ],
      );
    })??false;
  }

  @override
  Future<void> editGivenNameVaccine({required BuildContext context,
    required VaccineEntity model, required String name}) async {
    try {
      final entity = VaccineEntity(
        id: model.id,
        imageVaccine: model.imageVaccine,
        familyName: model.familyName,
        givenName: name,
        encoded: model.encoded,
        date: model.date,
        dob: model.dob,
        imageId: model.imageId,
      );
      await database.vaccineEntitysDao.updateVaccineById(id: model.id, entity: entity);
      FlashHelper.successBar(
        context: context,
        title: 'Edit Name',
        message: 'saved_success'.tr,
      );
    } catch(e) {
      logger.e(e);
      FlashHelper.errorBar(
        context: context,
        title: 'Edit Name',
        message: 'something_wrong'.tr,
      );
    }
  }

  @override
  Future<void> editVaccineFilePassport(BuildContext context, VaccineEntity model, File croppedFile) async {
    try {
      Uint8List? audioByte = await compressFile(croppedFile);
      String img = base64.encode(audioByte!);
      final entity = VaccineEntity(
        id: model.id,
        familyName: model.familyName,
        givenName: model.givenName,
        imageId: model.imageId,
        imageVaccine: img,
        date: model.date,
        dob: model.dob,
        encoded: '',
      );
      await database.vaccineEntitysDao.insertVaccine(entity);
      FlashHelper.successBar(
        context: context,
        title: 'Scan Passport',
        message: 'saved_success'.tr,
      );
    } catch(e) {
      logger.e(e);
      FlashHelper.errorBar(
        context: context,
        title: 'Scan Passport',
        message: 'something_wrong'.tr,
      );
    }
  }
}