import 'package:vaccpass/core/database/app_database.dart';
import 'dart:convert';


TracerModel tracerModelFromJson(String str, String encoded) => TracerModel.fromJson(json.decode(str), encoded);

String tracerModelToJson(TracerModel data) => json.encode(data.toJson());

class TracerModel extends LocationEntity {
  TracerModel({
    this.typ,
    required this.gln,
    required this.encoded,
    this.opn,
    this.adr,
    this.ver,
  }) : super(
    typ: typ,
    gln: gln,
    encoded: encoded,
    opn: opn,
    adr: adr,
    ver: ver,
    date: DateTime.now(),
  );

  String? typ;
  String gln;
  String encoded;
  String? opn;
  String? adr;
  String? ver;

  factory TracerModel.fromJson(Map<String, dynamic> json, String encoded) => TracerModel(
    typ: json["typ"],
    gln: json["gln"],
    encoded: encoded,
    opn: json["opn"],
    adr: json["adr"],
    ver: json["ver"],
  );

  Map<String, dynamic> toJsonModel() => {
    "typ": typ,
    "gln": gln,
    "opn": opn,
    "adr": adr,
    "ver": ver,
  };
}
