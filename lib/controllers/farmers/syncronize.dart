import 'dart:convert';

import 'package:FoodWings/models/farmers/create_farmer.dart';
import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../models/misc/error_message.dart';
import '../../network_services/databaseheleper.dart';
import '../../network_services/network_handler.dart';

class SyncronizationData {
  static var client = http.Client();
  static GetStorage store = GetStorage();
  static String auth = store.read("auth");

  static Future<bool> isInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      if (await DataConnectionChecker().hasConnection) {
        return true;
      } else {
        return false;
      }
    } else if (connectivityResult == ConnectivityResult.wifi) {
      if (await DataConnectionChecker().hasConnection) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  final conn = SqfliteDatabaseHelper.instance;

  Future<List<CreateFarmer>> fetchAllFarmers() async {
    final dbClient = await conn.db;
    List<CreateFarmer> farmerList = [];
    try {
      final maps = await dbClient!.query(SqfliteDatabaseHelper.farmertable);
      for (var item in maps) {
        farmerList.add(CreateFarmer.fromJson(item));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return farmerList;
  }

  Future saveToMysqlWith(List<CreateFarmer> farmerList) async {
    var url = NetWorkHandler.buildUrl("farmer/add");
    for (var i = 0; i < farmerList.length; i++) {
      Map<String, dynamic> data = {
        "district_id": farmerList[i].districtId.toString(),
        "msisdn": farmerList[i].msisdn.toString(),
        "farmer_name": farmerList[i].farmerName,
        "area": farmerList[i].area,
      };
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Accept': 'application/json',
        'AUTH': '$auth',
      };
      if (kDebugMode) {
        print(data);
      }
      var response = await client.post(url, headers: headers, body: data);

      var jsonString = response.body;

      if (response.statusCode == 200) {
        return [createFarmerFromJson(jsonString), response.statusCode];
      } else {
        var data = jsonDecode(response.body);
        return [erroMessageFromJson(jsonString), response.statusCode];
      }
    }
  }

  Future<List> fetchAllFarmerDetails() async {
    final dbClient = await conn.db;
    List farmerList = [];
    try {
      final maps = await dbClient!.query(SqfliteDatabaseHelper.farmertable);
      for (var item in maps) {
        farmerList.add(item);
      }
    } catch (e) {
      print(e.toString());
    }
    return farmerList;
  }

  Future saveToMysql(List farmerList) async {
    var url = NetWorkHandler.buildUrl("farmer/add");
    for (var i = 0; i < farmerList.length; i++) {
      Map<String, dynamic> data = {
        "district_id": farmerList[i].districtId.toString(),
        "msisdn": farmerList[i].msisdn.toString(),
        "farmer_name": farmerList[i].farmerName,
        "area": farmerList[i].area
      };

      Map<String, String> headers = {
        "Content-type": "application/json",
        'Accept': 'application/json',
        'AUTH': '$auth',
      };
      if (kDebugMode) {
        print(data);
      }
      var response = await client.post(url, headers: headers, body: data);

      var jsonString = response.body;

      if (response.statusCode == 200) {
        return [createFarmerFromJson(jsonString), response.statusCode];
      } else {
        var data = jsonDecode(response.body);
        return [erroMessageFromJson(jsonString), response.statusCode];
      }
    }
  }
}
