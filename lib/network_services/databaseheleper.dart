import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqfliteDatabaseHelper {
  SqfliteDatabaseHelper.internal();
  static final SqfliteDatabaseHelper instance =
      SqfliteDatabaseHelper.internal();
  factory SqfliteDatabaseHelper() => instance;

  static const farmertable = 'farmertable';
  static const _version = 1;

  static Database? _db;

  Future<Database?> get db async {
    _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String dbPath = join(directory.path, 'syncdatabase.db');
    var openDb = await openDatabase(dbPath, version: _version,
        onCreate: (Database db, int version) async {
      db.execute(""" 
      CREATE TABLE $farmertable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        district_id INTERGER NOT NULL,
        farmer_name TEXT,
        msisdn TEXT,
        area TEXT

      )""");
    }, onDowngrade: (Database db, int oldversion, int newversion) async {
      if (oldversion < newversion) {
        if (kDebugMode) {
          print("Version upgrade");
        }
      }
    });
    return openDb;
  }
}

// required this.farmerName,
//         required this.msisdn,
//         required this.districtId,
//         required this.area,