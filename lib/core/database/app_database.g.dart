// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class ScanEntity extends DataClass implements Insertable<ScanEntity> {
  final String id;
  final String? givenName;
  final String? familyName;
  final DateTime? dob;
  final DateTime? date;
  ScanEntity(
      {required this.id, this.givenName, this.familyName, this.dob, this.date});
  factory ScanEntity.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ScanEntity(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      givenName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}given_name']),
      familyName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}family_name']),
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
    if (!nullToAbsent || dob != null) {
      map['dob'] = Variable<DateTime?>(dob);
    }
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<DateTime?>(date);
    }
    return map;
  }

  ScanEntitysCompanion toCompanion(bool nullToAbsent) {
    return ScanEntitysCompanion(
      id: Value(id),
      givenName: givenName == null && nullToAbsent
          ? const Value.absent()
          : Value(givenName),
      familyName: familyName == null && nullToAbsent
          ? const Value.absent()
          : Value(familyName),
      dob: dob == null && nullToAbsent ? const Value.absent() : Value(dob),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
    );
  }

  factory ScanEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ScanEntity(
      id: serializer.fromJson<String>(json['id']),
      givenName: serializer.fromJson<String?>(json['givenName']),
      familyName: serializer.fromJson<String?>(json['familyName']),
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
      'dob': serializer.toJson<DateTime?>(dob),
      'date': serializer.toJson<DateTime?>(date),
    };
  }

  ScanEntity copyWith(
          {String? id,
          String? givenName,
          String? familyName,
          DateTime? dob,
          DateTime? date}) =>
      ScanEntity(
        id: id ?? this.id,
        givenName: givenName ?? this.givenName,
        familyName: familyName ?? this.familyName,
        dob: dob ?? this.dob,
        date: date ?? this.date,
      );
  @override
  String toString() {
    return (StringBuffer('ScanEntity(')
          ..write('id: $id, ')
          ..write('givenName: $givenName, ')
          ..write('familyName: $familyName, ')
          ..write('dob: $dob, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, givenName, familyName, dob, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScanEntity &&
          other.id == this.id &&
          other.givenName == this.givenName &&
          other.familyName == this.familyName &&
          other.dob == this.dob &&
          other.date == this.date);
}

class ScanEntitysCompanion extends UpdateCompanion<ScanEntity> {
  final Value<String> id;
  final Value<String?> givenName;
  final Value<String?> familyName;
  final Value<DateTime?> dob;
  final Value<DateTime?> date;
  const ScanEntitysCompanion({
    this.id = const Value.absent(),
    this.givenName = const Value.absent(),
    this.familyName = const Value.absent(),
    this.dob = const Value.absent(),
    this.date = const Value.absent(),
  });
  ScanEntitysCompanion.insert({
    required String id,
    this.givenName = const Value.absent(),
    this.familyName = const Value.absent(),
    this.dob = const Value.absent(),
    this.date = const Value.absent(),
  }) : id = Value(id);
  static Insertable<ScanEntity> custom({
    Expression<String>? id,
    Expression<String?>? givenName,
    Expression<String?>? familyName,
    Expression<DateTime?>? dob,
    Expression<DateTime?>? date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (givenName != null) 'given_name': givenName,
      if (familyName != null) 'family_name': familyName,
      if (dob != null) 'dob': dob,
      if (date != null) 'date': date,
    });
  }

  ScanEntitysCompanion copyWith(
      {Value<String>? id,
      Value<String?>? givenName,
      Value<String?>? familyName,
      Value<DateTime?>? dob,
      Value<DateTime?>? date}) {
    return ScanEntitysCompanion(
      id: id ?? this.id,
      givenName: givenName ?? this.givenName,
      familyName: familyName ?? this.familyName,
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
    return (StringBuffer('ScanEntitysCompanion(')
          ..write('id: $id, ')
          ..write('givenName: $givenName, ')
          ..write('familyName: $familyName, ')
          ..write('dob: $dob, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

class $ScanEntitysTable extends ScanEntitys
    with TableInfo<$ScanEntitysTable, ScanEntity> {
  final GeneratedDatabase _db;
  final String? _alias;
  $ScanEntitysTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _givenNameMeta = const VerificationMeta('givenName');
  late final GeneratedColumn<String?> givenName = GeneratedColumn<String?>(
      'given_name', aliasedName, true,
      typeName: 'TEXT',
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  final VerificationMeta _familyNameMeta = const VerificationMeta('familyName');
  late final GeneratedColumn<String?> familyName = GeneratedColumn<String?>(
      'family_name', aliasedName, true,
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
  List<GeneratedColumn> get $columns => [id, givenName, familyName, dob, date];
  @override
  String get aliasedName => _alias ?? 'scan_entitys';
  @override
  String get actualTableName => 'scan_entitys';
  @override
  VerificationContext validateIntegrity(Insertable<ScanEntity> instance,
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
  ScanEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ScanEntity.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ScanEntitysTable createAlias(String alias) {
    return $ScanEntitysTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $ScanEntitysTable scanEntitys = $ScanEntitysTable(this);
  late final ScanEntitysDao scanEntitysDao =
      ScanEntitysDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [scanEntitys];
}
