import 'package:vaccpass/core/database/app_database.dart';
import 'package:moor/moor.dart';

part 'scan_entitys.g.dart';

class ScanEntitys extends Table {

  TextColumn get id => text()();
  TextColumn get givenName => text().nullable().withDefault(const Constant(''))();
  TextColumn get familyName => text().nullable().withDefault(const Constant(''))();
  TextColumn get encoded => text().nullable().withDefault(const Constant(''))();
  TextColumn get imageId => text().nullable().withDefault(const Constant(''))();
  DateTimeColumn get dob => dateTime().nullable().withDefault(Constant(DateTime.now()))();
  DateTimeColumn get date => dateTime().nullable().withDefault(Constant(DateTime.now()))();

  @override
  Set<Column> get primaryKey => {id};
}

@UseDao(tables: [ScanEntitys])
class ScanEntitysDao extends DatabaseAccessor<AppDatabase>
    with _$ScanEntitysDaoMixin {

  final AppDatabase db;
  ScanEntitysDao(this.db) : super(db);

  Stream<List<ScanEntity>> watchAllScanEntity() => select(scanEntitys).watch();
  Future<List<ScanEntity>> getAllScanEntity() => select(scanEntitys).get();

  Future<void> insertAllScanEntity(List<Insertable<PinEntity>> rows) => batch((batch) =>
      batch.insertAll(scanEntitys, rows, mode: InsertMode.replace));
  Future insertScanEntity(Insertable<ScanEntity> row) => into(scanEntitys).insert(row, mode: InsertMode.replace);
  Future updateScanEntity(Insertable<ScanEntity> row) => update(scanEntitys).replace(row);
  Future deleteScanEntity(Insertable<ScanEntity> row) => delete(scanEntitys).delete(row);

  Stream<List<ScanEntity>> watchAllScanByDate() {
    return (select(scanEntitys)
      ..orderBy([
            (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc)
      ])
    ).watch();
  }

  Future<void> updateScanImage({required String id, required String imageId}) {
    return (update(scanEntitys)
      ..where((t) => t.id.equals(id))
    ).write(ScanEntity(id: id, imageId: imageId));
  }
}
