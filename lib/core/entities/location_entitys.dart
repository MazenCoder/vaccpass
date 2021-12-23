import 'package:vaccpass/core/database/app_database.dart';
import 'package:moor/moor.dart';

part 'location_entitys.g.dart';

class LocationEntitys extends Table {

  TextColumn get gln => text()();
  TextColumn get encoded => text().nullable().withDefault(const Constant(''))();
  TextColumn get typ => text().nullable().withDefault(const Constant(''))();
  TextColumn get imageVaccine => text().nullable().withDefault(const Constant(''))();
  TextColumn get opn => text().nullable().withDefault(const Constant('New Location'))();
  TextColumn get adr => text().nullable().withDefault(const Constant(''))();
  TextColumn get ver => text().nullable().withDefault(const Constant(''))();
  DateTimeColumn get date => dateTime().nullable().withDefault(Constant(DateTime.now()))();

  @override
  Set<Column> get primaryKey => {gln};
}

@UseDao(tables: [LocationEntitys])
class LocationEntitysDao extends DatabaseAccessor<AppDatabase>
    with _$LocationEntitysDaoMixin {

  final AppDatabase db;
  LocationEntitysDao(this.db) : super(db);

  Stream<List<LocationEntity>> watchAllLocation() => select(locationEntitys).watch();
  Future<List<LocationEntity>> getAllLocation() => select(locationEntitys).get();

  Future<void> insertAllLocation(List<Insertable<LocationEntity>> rows) => batch((batch) =>
      batch.insertAll(locationEntitys, rows, mode: InsertMode.replace));
  Future insertLocation(Insertable<LocationEntity> row) => into(locationEntitys).insert(row, mode: InsertMode.replace);
  Future updateLocation(Insertable<LocationEntity> row) => update(locationEntitys).replace(row);
  Future deleteLocation(Insertable<LocationEntity> row) => delete(locationEntitys).delete(row);

  Future<LocationEntity?> getLocationQr(String qr) {
    return (select(locationEntitys)
      ..where((table) => table.encoded.equals(qr))
    ).getSingleOrNull();
  }

  Stream<List<LocationEntity>> watchAllLocationByDate() {
    return (select(locationEntitys)
      ..orderBy([
        (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc)
      ])
    ).watch();
  }
}
