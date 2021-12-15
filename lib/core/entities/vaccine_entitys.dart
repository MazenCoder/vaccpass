import 'package:vaccpass/core/database/app_database.dart';
import 'package:moor/moor.dart';

part 'vaccine_entitys.g.dart';

class VaccineEntitys extends Table {

  TextColumn get id => text()();
  TextColumn get givenName => text().nullable().withDefault(const Constant('New Passport'))();
  TextColumn get familyName => text().nullable().withDefault(const Constant(''))();
  TextColumn get encoded => text().nullable().withDefault(const Constant(''))();
  TextColumn get imageId => text().nullable().withDefault(const Constant(''))();
  TextColumn get imageVaccine => text().nullable().withDefault(const Constant(''))();
  DateTimeColumn get dob => dateTime().nullable().withDefault(Constant(DateTime.now()))();
  DateTimeColumn get date => dateTime().nullable().withDefault(Constant(DateTime.now()))();

  @override
  Set<Column> get primaryKey => {id};
}

@UseDao(tables: [VaccineEntitys])
class VaccineEntitysDao extends DatabaseAccessor<AppDatabase>
    with _$VaccineEntitysDaoMixin {

  final AppDatabase db;
  VaccineEntitysDao(this.db) : super(db);

  Stream<List<VaccineEntity>> watchAllVaccine() => select(vaccineEntitys).watch();
  Future<List<VaccineEntity>> getAllVaccine() => select(vaccineEntitys).get();

  Future<void> insertAllVaccine(List<Insertable<PinEntity>> rows) => batch((batch) =>
      batch.insertAll(vaccineEntitys, rows, mode: InsertMode.replace));
  Future insertVaccine(Insertable<VaccineEntity> row) => into(vaccineEntitys).insert(row, mode: InsertMode.replace);
  Future updateVaccine(Insertable<VaccineEntity> row) => update(vaccineEntitys).replace(row);
  Future deleteVaccine(Insertable<VaccineEntity> row) => delete(vaccineEntitys).delete(row);

  Stream<List<VaccineEntity>> watchAllScanByDate() {
    return (select(vaccineEntitys)
      ..orderBy([
          (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc)
      ])
    ).watch();
  }

  Future<void> updateScanImage({required String id, required String imageId}) {
    return (update(vaccineEntitys)
      ..where((t) => t.id.equals(id))
    ).write(VaccineEntity(id: id, imageId: imageId));
  }

  Future<void> updateVaccineById({required String id, required VaccineEntity entity}) {
    return (update(vaccineEntitys)
      ..where((t) => t.id.equals(id))
    ).write(entity);
  }

  Stream<VaccineEntity?> watchVaccineById(String id) {
    return (select(vaccineEntitys)
      ..where((table) => table.id.equals(id))
    ).watchSingleOrNull();
  }
}
