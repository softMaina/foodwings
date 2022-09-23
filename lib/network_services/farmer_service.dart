import 'dart:convert';

import 'package:FoodWings/models/misc/error_message.dart';
import 'package:FoodWings/screens/farmer/add_famer.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../models/farmers/create_farmer.dart';
import '../models/farmers/farmer.dart';
import '../models/farmers/view_farmer.dart';
import '../models/regions/region_model.dart';
import 'network_handler.dart';
import 'package:get/get.dart';

class FarmerService {
  static var client = http.Client();
  static GetStorage store = GetStorage();
  static String auth = store.read("auth");

  static Future createFamerService(String _farmerName, String _msisdn,
      String _area, String _districtId) async {
    var url = NetWorkHandler.buildUrl("farmer/add");
    CreateFarmer createFarmer = CreateFarmer(
        farmerName: _farmerName,
        msisdn: _msisdn,
        districtId: int.parse(_districtId),
        area: _area);

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Accept': 'application/json',
      'AUTH': 'blhGVzMwcWFLOFRrUUJXdTZZN0JXMklKRG1VSEhuTFU3OGxMeVE4S2pQaEx3OHBuQ00yU1FyeU5DQmdXWFdGWkdPV3Q2ays2L0JDd21HQzVlemJHM2Yyb0g4STNtWkcvUzFKZ1ZVaytIczU5cm5TUTFtL0d5Yk5YMCs2V1FsTmY3T3BxN1Z4Sm8vVDJxZGZkcE1uWjA3ZUF3T1Z4SkI4Um5kQjlKWit5WllsYlNjOUp3MHRMWGs4aVIxTGRuWXJRSXN4bVhxbk5MWHJPeUM3VkRzb0VSamRFdE9XbE5rdndqK3FGVjNiOE1xMUtJWDFKL1pjT1JDWER1bUhRN3Awaw',
    };


    var body = createFarmerToJson(createFarmer);


    var response = await client.post(url, headers: headers, body: body);
    var jsonString = response.body;

    if (response.statusCode == 200) {
      return [createFarmerFromJson(jsonString), response.statusCode];
    } else {
      var data = jsonDecode(response.body);
      return [erroMessageFromJson(jsonString), response.statusCode];
    }
  }

  Future addFarmer(Farmer farmer) async{
    var url = NetWorkHandler.buildUrl("farmer/add");


      Map<String, String> headers = {
        "Content-type": "application/json",
        'Accept': 'application/json',
        'AUTH': 'blhGVzMwcWFLOFRrUUJXdTZZN0JXMklKRG1VSEhuTFU3OGxMeVE4S2pQaEx3OHBuQ00yU1FyeU5DQmdXWFdGWkdPV3Q2ays2L0JDd21HQzVlemJHM2Yyb0g4STNtWkcvUzFKZ1ZVaytIczU5cm5TUTFtL0d5Yk5YMCs2V1FsTmY3T3BxN1Z4Sm8vVDJxZGZkcE1uWjA3ZUF3T1Z4SkI4Um5kQjlKWit5WllsYlNjOUp3MHRMWGs4aVIxTGRuWXJRSXN4bVhxbk5MWHJPeUM3VkRzb0VSamRFdE9XbE5rdndqK3FGVjNiOE1xMUtJWDFKL1pjT1JDWER1bUhRN3Awaw',
      };


      var response = await client.post(url, headers: headers, body: jsonEncode(farmer.toMap()));

      var jsonString = response.body;
      print(jsonString);
      if (response.statusCode == 200) {
        return 'success';
      } else {
        var data = jsonDecode(response.body);
        return [erroMessageFromJson(jsonString), response.statusCode];
      }

  }

  static Future addFarmerService(List<CreateFarmer> farmerList) async {
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
        'AUTH': 'blhGVzMwcWFLOFRrUUJXdTZZN0JXMklKRG1VSEhuTFU3OGxMeVE4S2pQaEx3OHBuQ00yU1FyeU5DQmdXWFdGWkdPV3Q2ays2L0JDd21HQzVlemJHM2Yyb0g4STNtWkcvUzFKZ1ZVaytIczU5cm5TUTFtL0d5Yk5YMCs2V1FsTmY3T3BxN1Z4Sm8vVDJxZGZkcE1uWjA3ZUF3T1Z4SkI4Um5kQjlKWit5WllsYlNjOUp3MHRMWGs4aVIxTGRuWXJRSXN4bVhxbk5MWHJPeUM3VkRzb0VSamRFdE9XbE5rdndqK3FGVjNiOE1xMUtJWDFKL1pjT1JDWER1bUhRN3Awaw',
      };
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

  static Future viewFarmerService() async {
    var url = NetWorkHandler.buildUrl("farmer/all");

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Accept': 'application/json',
      'AUTH': 'blhGVzMwcWFLOFRrUUJXdTZZN0JXMklKRG1VSEhuTFU3OGxMeVE4S2pQaEx3OHBuQ00yU1FyeU5DQmdXWFdGWkdPV3Q2ays2L0JDd21HQzVlemJHM2Yyb0g4STNtWkcvUzFKZ1ZVaytIczU5cm5TUTFtL0d5Yk5YMCs2V1FsTmY3T3BxN1Z4Sm8vVDJxZGZkcE1uWjA3ZUF3T1Z4SkI4Um5kQjlKWit5WllsYlNjOUp3MHRMWGs4aVIxTGRuWXJRSXN4bVhxbk5MWHJPeUM3VkRzb0VSamRFdE9XbE5rdndqK3FGVjNiOE1xMUtJWDFKL1pjT1JDWER1bUhRN3Awaw==',
    };
    var response = await client.get(url, headers: headers);

    var jsonString = response.body;

    if (response.statusCode == 200) {
      return [viewFarmerModelFromJson(jsonString), response.statusCode];
    } else {
      Get.snackbar("Error", jsonString.toString());
      return [erroMessageFromJson(jsonString), response.statusCode];
    }
  }
}