import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/farm/farm_model.dart';
import '../models/farm/farm.dart';
import '../models/farmers/farmer.dart';

class DbHelper {
  final int version = 1;
  Database? db;

  Future<Database?> openDb() async {
    if (db == null) {
      db = await openDatabase(join(await getDatabasesPath(), 'foodwings.db'),
          onCreate: (database, version) {
        database.execute(
            'CREATE TABLE farmers(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, msisdn TEXT, district_id INTEGER, area TEXT)');
        database.execute(
            'CREATE TABLE farms(id INTEGER PRIMARY KEY AUTOINCREMENT,farmer_id INTEGER, district_id INTEGER, crop_id INTEGER, ploughing_date TEXT, planting_date TEXT,area TEXT, coordinates TEXT, FOREIGN KEY(farmer_id) REFERENCES farmer(id))');
      }, version: version);
    }
    return db;
  }

  Future testDb() async {
    db = await openDb();
  }

  // farmers
  Future<int?> insertFarmer(Farmer farmer) async {
    db = await openDb();
    int? id = await db?.insert('farmers', farmer.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future getFarmers() async {
    db = await openDb();
    List<Map<String, Object?>>? maps = await db?.query('farmers');
    List<Farmer> farmers = [];
    maps?.forEach((element) {
      farmers.add(Farmer(element['name'] as String, element['msisdn'] as String,
          element['district_id'] as int, element['area'] as String));
    });

    return farmers;
  }

  Future getFarmerAndFarms() async {
    db = await openDb();
    List<Map<String, Object?>>? farmers =await db?.rawQuery(
        'SELECT * FROM farmers');
    List results = [];
    farmers?.forEach((element) {
      // for each farmer get his farms

      var farms = db?.rawQuery('select * from farms where farmer_id = ?',[element['id']]);

      var f = {
        "name": element['name'],
        "msisdn": element['msisdn'],
        "district_id": element['districtId'],
        "area": element['area'],
        'farms': farms,
      };
      results.add(f);
    });
    return results;
  }

  Future<int?> deleteFarmer(int id) async {
    db = await openDb();
    return await db?.delete('farmers', where: 'id = ?', whereArgs: [id]);
  }

  Future<int?> updateFarmer(Farmer farmer) async {
    db = await openDb();
    return await db?.update('farmers', farmer.toMap(),
        where: 'id = ?', whereArgs: [farmer.id]);
  }

  // farms
  Future<int?> insertFarm(Farm farm) async {
    db = await openDb();
    int? id = await db?.insert('farms', farm.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future getFarms() async {
    db = await openDb();
    List<Map<String, Object?>>? maps = await db?.query('farms');
    List<Farm> farms = [];
    maps?.forEach((element) {
      farms.add(Farm(
          element['farmer_id'] as int,
          element['district_id'] as int,
          element['crop_id'] as int,
          element['ploughing_date'] as String,
          element['planting_date'] as String,
          element['area'] as String,
          element['coordinates'] as String));
    });
    return farms;
  }

  Future<int?> deleteFarm(int id) async {
    db = await openDb();
    return await db?.delete('farms', where: 'id = ?', whereArgs: [id]);
  }

  Future<int?> updateFarm(Farm farm) async {
    db = await openDb();
    return await db?.update('farms', farm.toMap(),
        where: 'id = ?', whereArgs: [farm.farmerId]);
  }

  Future close() async => db?.close();
}
