import 'package:vaccpass/core/entities/tracer_entitys.dart';
import 'package:vaccpass/core/entities/scan_entitys.dart';
import 'package:vaccpass/core/entities/pin_entitys.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:moor/moor.dart';

part 'app_database.g.dart';

@UseMoor(
    /// All Tables
    tables: [
      ScanEntitys,
      TracerEntitys,
      PinEntitys,
    ],
    /// All Daos
    daos: [
      ScanEntitysDao,
      TracerEntitysDao,
      PinEntitysDao,
    ],
    /// All Queries
    queries: {

    },
)
class AppDatabase extends _$AppDatabase {

  AppDatabase() : super((FlutterQueryExecutor.inDatabaseFolder(
    path: 'db.vaccpass',
    logStatements: true,
  )));

  Future<void> deleteAllData() {
    return transaction(() async {
      for (var table in allTables) {
        await delete(table).go();
      }
    });
  }

  @override
  MigrationStrategy get migration => MigrationStrategy(

    onUpgrade: (migrator, from, to) async {
      // if (from == 1) {
      //   await migrator.drop(emploitemps);
      //   await migrator.createTable(plats);
      //   await migrator.createTable(planCantines);
      //   await migrator.addColumn(agendaPhotoDetails, agendaPhotoDetails.id_personne);
      //
      //   await migrator.createTable(emploitemps);
      //   await migrator.addColumn(seances, seances.id_personne_eleve);
      // }
    },
  );

  @override
  int get schemaVersion => 1;

  //! SINGLETON
  static final AppDatabase _singleton = AppDatabase._internal();
  AppDatabase._internal() : super((FlutterQueryExecutor.inDatabaseFolder(
    path: 'db.vaccpass',
    logStatements: true,
  )));

  static AppDatabase get instance => _singleton;
}