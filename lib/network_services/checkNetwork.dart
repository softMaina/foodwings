import 'package:FoodWings/network_services/databaseheleper.dart';
import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/foundation.dart';

import '../models/farmers/create_farmer.dart';

class CheckConnection {
  final conn = SqfliteDatabaseHelper.instance;

  static Future<bool> inInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      if (await DataConnectionChecker().hasConnection) {
        if (kDebugMode) {
          print("Mobile data detected & internet Connection Confirmed.");
        }
        return true;
      } else {
        if (kDebugMode) {
          print('No internet :( Reason:');
        }
        return false;
      }
    } else if (connectivityResult == ConnectivityResult.wifi) {
      if (await DataConnectionChecker().hasConnection) {
        if (kDebugMode) {
          print("wifi data detected & internet connection confirmed.");
        }
        return true;
      } else {
        if (kDebugMode) {
          print('No internet :( Reason:');
        }
        return false;
      }
    } else {
      if (kDebugMode) {
        print(
            "Neither mobile data or WIFI detected, not internet connection found.");
      }
      return false;
    }
  }

  Future<int?> addFarmer(CreateFarmer createFarmer) async {
    var dbclient = await conn.db;
    int? result;
    try {
      result = await dbclient!
          .insert(SqfliteDatabaseHelper.farmertable, createFarmer.toJson());
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    if (kDebugMode) {
      print(result);
    }
    return result;
  }

  Future<int?> updateFarmer(CreateFarmer createFarmer) async {
    var dbclient = await conn.db;
    int? result;
    try {
      result = await dbclient!.update(
          SqfliteDatabaseHelper.farmertable, createFarmer.toJson(),
          where: 'msisdn =?', whereArgs: [createFarmer.msisdn]);
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  Future fetchFarmer() async {
    var dbclient = await conn.db;
    List userList = [];
    try {
      List<Map<String, dynamic>> maps = await dbclient!
          .query(SqfliteDatabaseHelper.farmertable, orderBy: 'id DESC');
      for (var item in maps) {
        userList.add(item);
      }
    } catch (e) {
      print(e.toString());
    }
    return userList;
  }
}
