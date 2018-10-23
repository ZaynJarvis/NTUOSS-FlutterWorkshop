import 'dart:async';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  final String tableName = 'COUNTRIES';
  final String dbDir = 'country.db';
  final String isBase = 'base';
  final String countryName = 'country';

  static Database _db;

  DatabaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = '$databasesPath/$dbDir';

    // await deleteDatabase(path); // for testing

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $tableName($countryName TEXT PRIMARY KEY, $isBase INTEGER )');
  }

  Future<void> saveCountry(String country) async {
    var dbClient = await db;
    if (!await this.hasCountry(country)) {
      await dbClient.insert(tableName, {countryName: country, isBase: 0});
    }
  }

  Future<List> getAllCountries() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery('SELECT * FROM $tableName');
    return result;
  }

  Future<bool> hasCountry(String country) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(tableName,
        columns: [countryName, isBase],
        where: '$countryName = ?',
        whereArgs: [country]);
    if (result.length > 0) {
      return true;
    }
    return false;
  }

  Future<dynamic> findBase() async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(tableName,
        columns: [countryName, isBase], where: '$isBase = ?', whereArgs: [1]);
    if (result.length > 0) {
      return result[0]['country'];
    }
    return null;
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery('SELECT COUNT(*) FROM $tableName'));
  }

  Future<int> deleteCountry(String country) async {
    var dbClient = await db;
    // return await dbClient
    //     .rawDelete('DELETE FROM $tableName WHERE $countryName = "$country"');
    return await dbClient
        .delete(tableName, where: '$countryName = ?', whereArgs: [country]);
  }

  Future<int> updateBase(String baseCountry) async {
    var dbClient = await db;
    return await dbClient.transaction((txn) async {
      var batch = txn.batch();
      batch.update(tableName, {'base': 0},
          where: "$isBase = ?", whereArgs: [1]);
      batch.update(tableName, {'country': baseCountry, 'base': 1},
          where: "$countryName = ?", whereArgs: [baseCountry]);
      await batch.commit();
    });
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
