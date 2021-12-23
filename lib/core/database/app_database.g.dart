// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class VaccineEntity extends DataClass implements Insertable<VaccineEntity> {
  final String id;
  final String? givenName;
  final String? familyName;
  final String? encoded;
  final String? imageId;
  final String? imageVaccine;
  final DateTime? dob;
  final DateTime? date;
  VaccineEntity(
      {required this.id,
      this.givenName,
      this.familyName,
      this.encoded,
      this.imageId,
      this.imageVaccine,
      this.dob,
      this.date});
  factory VaccineEntity.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return VaccineEntity(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      givenName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}given_name']),
      familyName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}family_name']),
      encoded: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}encoded']),
      imageId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}image_id']),
      imageVaccine: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}image_vaccine']),
      dob: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}dob']),
      date: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || givenName != null) {
      map['given_name'] = Variable<String?>(givenName);
    }
    if (!nullToAbsent || familyName != null) {
      map['family_name'] = Variable<String?>(familyName);
    }
    if (!nullToAbsent || encoded != null) {
      map['encoded'] = Variable<String?>(encoded);
    }
    if (!nullToAbsent || imageId != null) {
      map['image_id'] = Variable<String?>(imageId);
    }
    if (!nullToAbsent || imageVaccine != null) {
      map['image_vaccine'] = Variable<String?>(imageVaccine);
    }
    if (!nullToAbsent || dob != null) {
      map['dob'] = Variable<DateTime?>(dob);
    }
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<DateTime?>(date);
    }
    return map;
  }

  VaccineEntitysCompanion toCompanion(bool nullToAbsent) {
    return VaccineEntitysCompanion(
      id: Value(id),
      givenName: givenName == null && nullToAbsent
          ? const Value.absent()
          : Value(givenName),
      familyName: familyName == null && nullToAbsent
          ? const Value.absent()
          : Value(familyName),
      encoded: encoded == null && nullToAbsent
          ? const Value.absent()
          : Value(encoded),
      imageId: imageId == null && nullToAbsent
          ? const Value.absent()
          : Value(imageId),
      imageVaccine: imageVaccine == null && nullToAbsent
          ? const Value.absent()
          : Value(imageVaccine),
      dob: dob == null && nullToAbsent ? const Value.absent() : Value(dob),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
    );
  }

  factory VaccineEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return VaccineEntity(
      id: serializer.fromJson<String>(json['id']),
      givenName: serializer.fromJson<String?>(json['givenName']),
      familyName: serializer.fromJson<String?>(json['familyName']),
      encoded: serializer.fromJson<String?>(json['encoded']),
      imageId: serializer.fromJson<String?>(json['imageId']),
      imageVaccine: serializer.fromJson<String?>(json['imageVaccine']),
      dob: serializer.fromJson<DateTime?>(json['dob']),
      date: serializer.fromJson<DateTime?>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'givenName': serializer.toJson<String?>(givenName),
      'familyName': serializer.toJson<String?>(familyName),
      'encoded': serializer.toJson<String?>(encoded),
      'imageId': serializer.toJson<String?>(imageId),
      'imageVaccine': serializer.toJson<String?>(imageVaccine),
      'dob': serializer.toJson<DateTime?>(dob),
      'date': serializer.toJson<DateTime?>(date),
    };
  }

  VaccineEntity copyWith(
          {String? id,
          String? givenName,
          String? familyName,
          String? encoded,
          String? imageId,
          String? imageVaccine,
          DateTime? dob,
          DateTime? date}) =>
      VaccineEntity(
        id: id ?? this.id,
        givenName: givenName ?? this.givenName,
        familyName: familyName ?? this.familyName,
        encoded: encoded ?? this.encoded,
        imageId: imageId ?? this.imageId,
        imageVaccine: imageVaccine ?? this.imageVaccine,
        dob: dob ?? this.dob,
        date: date ?? this.date,
      );
  @override
  String toString() {
    return (StringBuffer('VaccineEntity(')
          ..write('id: $id, ')
          ..write('givenName: $givenName, ')
          ..write('familyName: $familyName, ')
          ..write('encoded: $encoded, ')
          ..write('imageId: $imageId, ')
          ..write('imageVaccine: $imageVaccine, ')
          ..write('dob: $dob, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, givenName, familyName, encoded, imageId, imageVaccine, dob, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VaccineEntity &&
          other.id == this.id &&
          other.givenName == this.givenName &&
          other.familyName == this.familyName &&
          other.encoded == this.encoded &&
          other.imageId == this.imageId &&
          other.imageVaccine == this.imageVaccine &&
          other.dob == this.dob &&
          other.date == this.date);
}

class VaccineEntitysCompanion extends UpdateCompanion<VaccineEntity> {
  final Value<String> id;
  final Value<String?> givenName;
  final Value<String?> familyName;
  final Value<String?> encoded;
  final Value<String?> imageId;
  final Value<String?> imageVaccine;
  final Value<DateTime?> dob;
  final Value<DateTime?> date;
  const VaccineEntitysCompanion({
    this.id = const Value.absent(),
    this.givenName = const Value.absent(),
    this.familyName = const Value.absent(),
    this.encoded = const Value.absent(),
    this.imageId = const Value.absent(),
    this.imageVaccine = const Value.absent(),
    this.dob = const Value.absent(),
    this.date = const Value.absent(),
  });
  VaccineEntitysCompanion.insert({
    required String id,
    this.givenName = const Value.absent(),
    this.familyName = const Value.absent(),
    this.encoded = const Value.absent(),
    this.imageId = const Value.absent(),
    this.imageVaccine = const Value.absent(),
    this.dob = const Value.absent(),
    this.date = const Value.absent(),
  }) : id = Value(id);
  static Insertable<VaccineEntity> custom({
    Expression<String>? id,
    Expression<String?>? givenName,
    Expression<String?>? familyName,
    Expression<String?>? encoded,
    Expression<String?>? imageId,
    Expression<String?>? imageVaccine,
    Expression<DateTime?>? dob,
    Expression<DateTime?>? date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (givenName != null) 'given_name': givenName,
      if (familyName != null) 'family_name': familyName,
      if (encoded != null) 'encoded': encoded,
      if (imageId != null) 'image_id': imageId,
      if (imageVaccine != null) 'image_vaccine': imageVaccine,
      if (dob != null) 'dob': dob,
      if (date != null) 'date': date,
    });
  }

  VaccineEntitysCompanion copyWith(
      {Value<String>? id,
      Value<String?>? givenName,
      Value<String?>? familyName,
      Value<String?>? encoded,
      Value<String?>? imageId,
      Value<String?>? imageVaccine,
      Value<DateTime?>? dob,
      Value<DateTime?>? date}) {
    return VaccineEntitysCompanion(
      id: id ?? this.id,
      givenName: givenName ?? this.givenName,
      familyName: familyName ?? this.familyName,
      encoded: encoded ?? this.encoded,
      imageId: imageId ?? this.imageId,
      imageVaccine: imageVaccine ?? this.imageVaccine,
      dob: dob ?? this.dob,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (givenName.present) {
      map['given_name'] = Variable<String?>(givenName.value);
    }
    if (familyName.present) {
      map['family_name'] = Variable<String?>(familyName.value);
    }
    if (encoded.present) {
      map['encoded'] = Variable<String?>(encoded.value);
    }
    if (imageId.present) {
      map['image_id'] = Variable<String?>(imageId.value);
    }
    if (imageVaccine.present) {
      map['image_vaccine'] = Variable<String?>(imageVaccine.value);
    }
    if (dob.present) {
      map['dob'] = Variable<DateTime?>(dob.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime?>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VaccineEntitysCompanion(')
          ..write('id: $id, ')
          ..write('givenName: $givenName, ')
          ..write('familyName: $familyName, ')
          ..write('encoded: $encoded, ')
          ..write('imageId: $imageId, ')
          ..write('imageVaccine: $imageVaccine, ')
          ..write('dob: $dob, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

class $VaccineEntitysTable extends VaccineEntitys
    with TableInfo<$VaccineEntitysTable, VaccineEntity> {
  final GeneratedDatabase _db;
  final String? _alias;
  $VaccineEntitysTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _givenNameMeta = const VerificationMeta('givenName');
  late final GeneratedColumn<String?> givenName = GeneratedColumn<String?>(
      'given_name', aliasedName, true,
      typeName: 'TEXT',
      requiredDuringInsert: false,
      defaultValue: const Constant('New Passport'));
  final VerificationMeta _familyNameMeta = const VerificationMeta('familyName');
  late final GeneratedColumn<String?> familyName = GeneratedColumn<String?>(
      'family_name', aliasedName, true,
      typeName: 'TEXT',
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  final VerificationMeta _encodedMeta = const VerificationMeta('encoded');
  late final GeneratedColumn<String?> encoded = GeneratedColumn<String?>(
      'encoded', aliasedName, true,
      typeName: 'TEXT',
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  final VerificationMeta _imageIdMeta = const VerificationMeta('imageId');
  late final GeneratedColumn<String?> imageId = GeneratedColumn<String?>(
      'image_id', aliasedName, true,
      typeName: 'TEXT',
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  final VerificationMeta _imageVaccineMeta =
      const VerificationMeta('imageVaccine');
  late final GeneratedColumn<String?> imageVaccine = GeneratedColumn<String?>(
      'image_vaccine', aliasedName, true,
      typeName: 'TEXT',
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  final VerificationMeta _dobMeta = const VerificationMeta('dob');
  late final GeneratedColumn<DateTime?> dob = GeneratedColumn<DateTime?>(
      'dob', aliasedName, true,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now()));
  final VerificationMeta _dateMeta = const VerificationMeta('date');
  late final GeneratedColumn<DateTime?> date = GeneratedColumn<DateTime?>(
      'date', aliasedName, true,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now()));
  @override
  List<GeneratedColumn> get $columns =>
      [id, givenName, familyName, encoded, imageId, imageVaccine, dob, date];
  @override
  String get aliasedName => _alias ?? 'vaccine_entitys';
  @override
  String get actualTableName => 'vaccine_entitys';
  @override
  VerificationContext validateIntegrity(Insertable<VaccineEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('given_name')) {
      context.handle(_givenNameMeta,
          givenName.isAcceptableOrUnknown(data['given_name']!, _givenNameMeta));
    }
    if (data.containsKey('family_name')) {
      context.handle(
          _familyNameMeta,
          familyName.isAcceptableOrUnknown(
              data['family_name']!, _familyNameMeta));
    }
    if (data.containsKey('encoded')) {
      context.handle(_encodedMeta,
          encoded.isAcceptableOrUnknown(data['encoded']!, _encodedMeta));
    }
    if (data.containsKey('image_id')) {
      context.handle(_imageIdMeta,
          imageId.isAcceptableOrUnknown(data['image_id']!, _imageIdMeta));
    }
    if (data.containsKey('image_vaccine')) {
      context.handle(
          _imageVaccineMeta,
          imageVaccine.isAcceptableOrUnknown(
              data['image_vaccine']!, _imageVaccineMeta));
    }
    if (data.containsKey('dob')) {
      context.handle(
          _dobMeta, dob.isAcceptableOrUnknown(data['dob']!, _dobMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VaccineEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    return VaccineEntity.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $VaccineEntitysTable createAlias(String alias) {
    return $VaccineEntitysTable(_db, alias);
  }
}

class LocationEntity extends DataClass implements Insertable<LocationEntity> {
  final String gln;
  final String? encoded;
  final String? typ;
  final String? imageVaccine;
  final String? opn;
  final String? adr;
  final String? ver;
  final DateTime? date;
  LocationEntity(
      {required this.gln,
      this.encoded,
      this.typ,
      this.imageVaccine,
      this.opn,
      this.adr,
      this.ver,
      this.date});
  factory LocationEntity.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return LocationEntity(
      gln: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}gln'])!,
      encoded: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}encoded']),
      typ: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}typ']),
      imageVaccine: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}image_vaccine']),
      opn: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}opn']),
      adr: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}adr']),
      ver: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}ver']),
      date: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['gln'] = Variable<String>(gln);
    if (!nullToAbsent || encoded != null) {
      map['encoded'] = Variable<String?>(encoded);
    }
    if (!nullToAbsent || typ != null) {
      map['typ'] = Variable<String?>(typ);
    }
    if (!nullToAbsent || imageVaccine != null) {
      map['image_vaccine'] = Variable<String?>(imageVaccine);
    }
    if (!nullToAbsent || opn != null) {
      map['opn'] = Variable<String?>(opn);
    }
    if (!nullToAbsent || adr != null) {
      map['adr'] = Variable<String?>(adr);
    }
    if (!nullToAbsent || ver != null) {
      map['ver'] = Variable<String?>(ver);
    }
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<DateTime?>(date);
    }
    return map;
  }

  LocationEntitysCompanion toCompanion(bool nullToAbsent) {
    return LocationEntitysCompanion(
      gln: Value(gln),
      encoded: encoded == null && nullToAbsent
          ? const Value.absent()
          : Value(encoded),
      typ: typ == null && nullToAbsent ? const Value.absent() : Value(typ),
      imageVaccine: imageVaccine == null && nullToAbsent
          ? const Value.absent()
          : Value(imageVaccine),
      opn: opn == null && nullToAbsent ? const Value.absent() : Value(opn),
      adr: adr == null && nullToAbsent ? const Value.absent() : Value(adr),
      ver: ver == null && nullToAbsent ? const Value.absent() : Value(ver),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
    );
  }

  factory LocationEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return LocationEntity(
      gln: serializer.fromJson<String>(json['gln']),
      encoded: serializer.fromJson<String?>(json['encoded']),
      typ: serializer.fromJson<String?>(json['typ']),
      imageVaccine: serializer.fromJson<String?>(json['imageVaccine']),
      opn: serializer.fromJson<String?>(json['opn']),
      adr: serializer.fromJson<String?>(json['adr']),
      ver: serializer.fromJson<String?>(json['ver']),
      date: serializer.fromJson<DateTime?>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'gln': serializer.toJson<String>(gln),
      'encoded': serializer.toJson<String?>(encoded),
      'typ': serializer.toJson<String?>(typ),
      'imageVaccine': serializer.toJson<String?>(imageVaccine),
      'opn': serializer.toJson<String?>(opn),
      'adr': serializer.toJson<String?>(adr),
      'ver': serializer.toJson<String?>(ver),
      'date': serializer.toJson<DateTime?>(date),
    };
  }

  LocationEntity copyWith(
          {String? gln,
          String? encoded,
          String? typ,
          String? imageVaccine,
          String? opn,
          String? adr,
          String? ver,
          DateTime? date}) =>
      LocationEntity(
        gln: gln ?? this.gln,
        encoded: encoded ?? this.encoded,
        typ: typ ?? this.typ,
        imageVaccine: imageVaccine ?? this.imageVaccine,
        opn: opn ?? this.opn,
        adr: adr ?? this.adr,
        ver: ver ?? this.ver,
        date: date ?? this.date,
      );
  @override
  String toString() {
    return (StringBuffer('LocationEntity(')
          ..write('gln: $gln, ')
          ..write('encoded: $encoded, ')
          ..write('typ: $typ, ')
          ..write('imageVaccine: $imageVaccine, ')
          ..write('opn: $opn, ')
          ..write('adr: $adr, ')
          ..write('ver: $ver, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(gln, encoded, typ, imageVaccine, opn, adr, ver, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocationEntity &&
          other.gln == this.gln &&
          other.encoded == this.encoded &&
          other.typ == this.typ &&
          other.imageVaccine == this.imageVaccine &&
          other.opn == this.opn &&
          other.adr == this.adr &&
          other.ver == this.ver &&
          other.date == this.date);
}

class LocationEntitysCompanion extends UpdateCompanion<LocationEntity> {
  final Value<String> gln;
  final Value<String?> encoded;
  final Value<String?> typ;
  final Value<String?> imageVaccine;
  final Value<String?> opn;
  final Value<String?> adr;
  final Value<String?> ver;
  final Value<DateTime?> date;
  const LocationEntitysCompanion({
    this.gln = const Value.absent(),
    this.encoded = const Value.absent(),
    this.typ = const Value.absent(),
    this.imageVaccine = const Value.absent(),
    this.opn = const Value.absent(),
    this.adr = const Value.absent(),
    this.ver = const Value.absent(),
    this.date = const Value.absent(),
  });
  LocationEntitysCompanion.insert({
    required String gln,
    this.encoded = const Value.absent(),
    this.typ = const Value.absent(),
    this.imageVaccine = const Value.absent(),
    this.opn = const Value.absent(),
    this.adr = const Value.absent(),
    this.ver = const Value.absent(),
    this.date = const Value.absent(),
  }) : gln = Value(gln);
  static Insertable<LocationEntity> custom({
    Expression<String>? gln,
    Expression<String?>? encoded,
    Expression<String?>? typ,
    Expression<String?>? imageVaccine,
    Expression<String?>? opn,
    Expression<String?>? adr,
    Expression<String?>? ver,
    Expression<DateTime?>? date,
  }) {
    return RawValuesInsertable({
      if (gln != null) 'gln': gln,
      if (encoded != null) 'encoded': encoded,
      if (typ != null) 'typ': typ,
      if (imageVaccine != null) 'image_vaccine': imageVaccine,
      if (opn != null) 'opn': opn,
      if (adr != null) 'adr': adr,
      if (ver != null) 'ver': ver,
      if (date != null) 'date': date,
    });
  }

  LocationEntitysCompanion copyWith(
      {Value<String>? gln,
      Value<String?>? encoded,
      Value<String?>? typ,
      Value<String?>? imageVaccine,
      Value<String?>? opn,
      Value<String?>? adr,
      Value<String?>? ver,
      Value<DateTime?>? date}) {
    return LocationEntitysCompanion(
      gln: gln ?? this.gln,
      encoded: encoded ?? this.encoded,
      typ: typ ?? this.typ,
      imageVaccine: imageVaccine ?? this.imageVaccine,
      opn: opn ?? this.opn,
      adr: adr ?? this.adr,
      ver: ver ?? this.ver,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (gln.present) {
      map['gln'] = Variable<String>(gln.value);
    }
    if (encoded.present) {
      map['encoded'] = Variable<String?>(encoded.value);
    }
    if (typ.present) {
      map['typ'] = Variable<String?>(typ.value);
    }
    if (imageVaccine.present) {
      map['image_vaccine'] = Variable<String?>(imageVaccine.value);
    }
    if (opn.present) {
      map['opn'] = Variable<String?>(opn.value);
    }
    if (adr.present) {
      map['adr'] = Variable<String?>(adr.value);
    }
    if (ver.present) {
      map['ver'] = Variable<String?>(ver.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime?>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocationEntitysCompanion(')
          ..write('gln: $gln, ')
          ..write('encoded: $encoded, ')
          ..write('typ: $typ, ')
          ..write('imageVaccine: $imageVaccine, ')
          ..write('opn: $opn, ')
          ..write('adr: $adr, ')
          ..write('ver: $ver, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

class $LocationEntitysTable extends LocationEntitys
    with TableInfo<$LocationEntitysTable, LocationEntity> {
  final GeneratedDatabase _db;
  final String? _alias;
  $LocationEntitysTable(this._db, [this._alias]);
  final VerificationMeta _glnMeta = const VerificationMeta('gln');
  late final GeneratedColumn<String?> gln = GeneratedColumn<String?>(
      'gln', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _encodedMeta = const VerificationMeta('encoded');
  late final GeneratedColumn<String?> encoded = GeneratedColumn<String?>(
      'encoded', aliasedName, true,
      typeName: 'TEXT',
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  final VerificationMeta _typMeta = const VerificationMeta('typ');
  late final GeneratedColumn<String?> typ = GeneratedColumn<String?>(
      'typ', aliasedName, true,
      typeName: 'TEXT',
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  final VerificationMeta _imageVaccineMeta =
      const VerificationMeta('imageVaccine');
  late final GeneratedColumn<String?> imageVaccine = GeneratedColumn<String?>(
      'image_vaccine', aliasedName, true,
      typeName: 'TEXT',
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  final VerificationMeta _opnMeta = const VerificationMeta('opn');
  late final GeneratedColumn<String?> opn = GeneratedColumn<String?>(
      'opn', aliasedName, true,
      typeName: 'TEXT',
      requiredDuringInsert: false,
      defaultValue: const Constant('New Location'));
  final VerificationMeta _adrMeta = const VerificationMeta('adr');
  late final GeneratedColumn<String?> adr = GeneratedColumn<String?>(
      'adr', aliasedName, true,
      typeName: 'TEXT',
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  final VerificationMeta _verMeta = const VerificationMeta('ver');
  late final GeneratedColumn<String?> ver = GeneratedColumn<String?>(
      'ver', aliasedName, true,
      typeName: 'TEXT',
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  final VerificationMeta _dateMeta = const VerificationMeta('date');
  late final GeneratedColumn<DateTime?> date = GeneratedColumn<DateTime?>(
      'date', aliasedName, true,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now()));
  @override
  List<GeneratedColumn> get $columns =>
      [gln, encoded, typ, imageVaccine, opn, adr, ver, date];
  @override
  String get aliasedName => _alias ?? 'location_entitys';
  @override
  String get actualTableName => 'location_entitys';
  @override
  VerificationContext validateIntegrity(Insertable<LocationEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('gln')) {
      context.handle(
          _glnMeta, gln.isAcceptableOrUnknown(data['gln']!, _glnMeta));
    } else if (isInserting) {
      context.missing(_glnMeta);
    }
    if (data.containsKey('encoded')) {
      context.handle(_encodedMeta,
          encoded.isAcceptableOrUnknown(data['encoded']!, _encodedMeta));
    }
    if (data.containsKey('typ')) {
      context.handle(
          _typMeta, typ.isAcceptableOrUnknown(data['typ']!, _typMeta));
    }
    if (data.containsKey('image_vaccine')) {
      context.handle(
          _imageVaccineMeta,
          imageVaccine.isAcceptableOrUnknown(
              data['image_vaccine']!, _imageVaccineMeta));
    }
    if (data.containsKey('opn')) {
      context.handle(
          _opnMeta, opn.isAcceptableOrUnknown(data['opn']!, _opnMeta));
    }
    if (data.containsKey('adr')) {
      context.handle(
          _adrMeta, adr.isAcceptableOrUnknown(data['adr']!, _adrMeta));
    }
    if (data.containsKey('ver')) {
      context.handle(
          _verMeta, ver.isAcceptableOrUnknown(data['ver']!, _verMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {gln};
  @override
  LocationEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    return LocationEntity.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $LocationEntitysTable createAlias(String alias) {
    return $LocationEntitysTable(_db, alias);
  }
}

class PinEntity extends DataClass implements Insertable<PinEntity> {
  final String id;
  final String? code;
  final bool active;
  PinEntity({required this.id, this.code, required this.active});
  factory PinEntity.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return PinEntity(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      code: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}code']),
      active: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}active'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || code != null) {
      map['code'] = Variable<String?>(code);
    }
    map['active'] = Variable<bool>(active);
    return map;
  }

  PinEntitysCompanion toCompanion(bool nullToAbsent) {
    return PinEntitysCompanion(
      id: Value(id),
      code: code == null && nullToAbsent ? const Value.absent() : Value(code),
      active: Value(active),
    );
  }

  factory PinEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return PinEntity(
      id: serializer.fromJson<String>(json['id']),
      code: serializer.fromJson<String?>(json['code']),
      active: serializer.fromJson<bool>(json['active']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'code': serializer.toJson<String?>(code),
      'active': serializer.toJson<bool>(active),
    };
  }

  PinEntity copyWith({String? id, String? code, bool? active}) => PinEntity(
        id: id ?? this.id,
        code: code ?? this.code,
        active: active ?? this.active,
      );
  @override
  String toString() {
    return (StringBuffer('PinEntity(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('active: $active')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, code, active);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PinEntity &&
          other.id == this.id &&
          other.code == this.code &&
          other.active == this.active);
}

class PinEntitysCompanion extends UpdateCompanion<PinEntity> {
  final Value<String> id;
  final Value<String?> code;
  final Value<bool> active;
  const PinEntitysCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.active = const Value.absent(),
  });
  PinEntitysCompanion.insert({
    required String id,
    this.code = const Value.absent(),
    this.active = const Value.absent(),
  }) : id = Value(id);
  static Insertable<PinEntity> custom({
    Expression<String>? id,
    Expression<String?>? code,
    Expression<bool>? active,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (active != null) 'active': active,
    });
  }

  PinEntitysCompanion copyWith(
      {Value<String>? id, Value<String?>? code, Value<bool>? active}) {
    return PinEntitysCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      active: active ?? this.active,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String?>(code.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PinEntitysCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('active: $active')
          ..write(')'))
        .toString();
  }
}

class $PinEntitysTable extends PinEntitys
    with TableInfo<$PinEntitysTable, PinEntity> {
  final GeneratedDatabase _db;
  final String? _alias;
  $PinEntitysTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _codeMeta = const VerificationMeta('code');
  late final GeneratedColumn<String?> code = GeneratedColumn<String?>(
      'code', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _activeMeta = const VerificationMeta('active');
  late final GeneratedColumn<bool?> active = GeneratedColumn<bool?>(
      'active', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (active IN (0, 1))',
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns => [id, code, active];
  @override
  String get aliasedName => _alias ?? 'pin_entitys';
  @override
  String get actualTableName => 'pin_entitys';
  @override
  VerificationContext validateIntegrity(Insertable<PinEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    }
    if (data.containsKey('active')) {
      context.handle(_activeMeta,
          active.isAcceptableOrUnknown(data['active']!, _activeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PinEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    return PinEntity.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $PinEntitysTable createAlias(String alias) {
    return $PinEntitysTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $VaccineEntitysTable vaccineEntitys = $VaccineEntitysTable(this);
  late final $LocationEntitysTable locationEntitys =
      $LocationEntitysTable(this);
  late final $PinEntitysTable pinEntitys = $PinEntitysTable(this);
  late final VaccineEntitysDao vaccineEntitysDao =
      VaccineEntitysDao(this as AppDatabase);
  late final LocationEntitysDao locationEntitysDao =
      LocationEntitysDao(this as AppDatabase);
  late final PinEntitysDao pinEntitysDao = PinEntitysDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [vaccineEntitys, locationEntitys, pinEntitys];
}
