import 'package:vaccpass/core/database/app_database.dart';
import 'package:moor/moor.dart';

part 'tracer_entitys.g.dart';

class TracerEntitys extends Table {

  TextColumn get gln => text()();
  TextColumn get encoded => text().nullable().withDefault(const Constant(''))();
  TextColumn get typ => text().nullable().withDefault(const Constant(''))();
  // TextColumn get gln => text().nullable().withDefault(const Constant(''))();
  TextColumn get opn => text().nullable().withDefault(const Constant(''))();
  TextColumn get adr => text().nullable().withDefault(const Constant(''))();
  TextColumn get ver => text().nullable().withDefault(const Constant(''))();
  // DateTimeColumn get dob => dateTime().nullable().withDefault(Constant(DateTime.now()))();
  DateTimeColumn get date => dateTime().nullable().withDefault(Constant(DateTime.now()))();

  @override
  Set<Column> get primaryKey => {gln};
}

@UseDao(tables: [TracerEntitys])
class TracerEntitysDao extends DatabaseAccessor<AppDatabase>
    with _$TracerEntitysDaoMixin {

  final AppDatabase db;
  TracerEntitysDao(this.db) : super(db);

  Stream<List<TracerEntity>> watchAllTracerEntity() => select(tracerEntitys).watch();
  Future<List<TracerEntity>> getAllTracerEntity() => select(tracerEntitys).get();

  Future<void> insertAllTracerEntity(List<Insertable<TracerEntity>> rows) => batch((batch) =>
      batch.insertAll(tracerEntitys, rows, mode: InsertMode.replace));
  Future insertTracerEntity(Insertable<TracerEntity> row) => into(tracerEntitys).insert(row, mode: InsertMode.replace);
  Future updateTracerEntity(Insertable<TracerEntity> row) => update(tracerEntitys).replace(row);
  Future deleteTracerEntity(Insertable<TracerEntity> row) => delete(tracerEntitys).delete(row);

  Future<TracerEntity?> getTracerQr(String qr) {
    return (select(tracerEntitys)
      ..where((table) => table.encoded.equals(qr))
    ).getSingleOrNull();
  }

  Stream<List<TracerEntity>> watchAllTracerByDate() {
    return (select(tracerEntitys)
      ..orderBy([
        (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc)
      ])
    ).watch();
  }
}
