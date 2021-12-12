import 'package:vaccpass/core/database/app_database.dart';
import 'package:moor/moor.dart';

part 'pin_entitys.g.dart';

class PinEntitys extends Table {

  TextColumn get id => text()();
  TextColumn get code => text().nullable()();
  BoolColumn get active => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

@UseDao(tables: [PinEntitys])
class PinEntitysDao extends DatabaseAccessor<AppDatabase>
    with _$PinEntitysDaoMixin {

  final AppDatabase db;
  PinEntitysDao(this.db) : super(db);

  Stream<List<PinEntity>> watchAllPinEntity() => select(pinEntitys).watch();
  Future<List<PinEntity>> getAllPinEntity() => select(pinEntitys).get();

  Future<void> insertAllPinEntity(List<Insertable<PinEntity>> rows) => batch((batch) =>
      batch.insertAll(pinEntitys, rows, mode: InsertMode.replace));
  Future insertPinEntity(Insertable<PinEntity> row) => into(pinEntitys).insert(row, mode: InsertMode.replace);
  Future updatePinEntity(Insertable<PinEntity> row) => update(pinEntitys).replace(row);
  Future deletePinEntity(Insertable<PinEntity> row) => delete(pinEntitys).delete(row);


  Future<void> updatePinCode({required String id, required bool active}) {
    return (update(pinEntitys)
      ..where((t) => t.id.equals(id))
    ).write(PinEntity(id: id, active: active));
  }

  Future<PinEntity?> verificationCode(String code) {
    return (select(pinEntitys)
      ..where((table) => table.code.equals(code))
    ).getSingleOrNull();
  }

  Future<PinEntity?> getPinCode(String id) {
    return (select(pinEntitys)
      ..where((table) => table.id.equals(id))
    ).getSingleOrNull();
  }

  Stream<PinEntity?> watchPinCode(String id) {
    return (select(pinEntitys)
      ..where((table) => table.id.equals(id))
    ).watchSingleOrNull();
  }
}
