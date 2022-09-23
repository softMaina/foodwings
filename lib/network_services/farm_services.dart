import 'dart:convert';

import 'package:FoodWings/models/misc/error_message.dart';
import 'package:FoodWings/screens/farmer/view_farmer_screen.dart';
import 'package:FoodWings/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../models/farm/farm_model.dart';
import 'network_handler.dart';

class FarmService {
  static var client = http.Client();
  static GetStorage store = GetStorage();
  static String auth = store.read("auth");

  static Future createFarmService(
      String _farmerId,
      String _districtId,
      String _cropId,
      DateTime plantingDate,
      DateTime ploughingDate,
      String _area,
      List<Coordinate> coordinates) async {
    var url = NetWorkHandler.buildUrl("farmer/add/farm");

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Accept': 'application/json',
      'AUTH': 'blhGVzMwcWFLOFRrUUJXdTZZN0JXMklKRG1VSEhuTFU3OGxMeVE4S2pQaEx3OHBuQ00yU1FyeU5DQmdXWFdGWkdPV3Q2ays2L0JDd21HQzVlemJHM2Yyb0g4STNtWkcvUzFKZ1ZVaytIczU5cm5TUTFtL0d5Yk5YMCs2V1FsTmY3T3BxN1Z4Sm8vVDJxZGZkcE1uWjA3ZUF3T1Z4SkI4Um5kQjlKWit5WllsYlNjOUp3MHRMWGs4aVIxTGRuWXJRSXN4bVhxbk5MWHJPeUM3VkRzb0VSamRFdE9XbE5rdndqK3FGVjNiOE1xMUtJWDFKL1pjT1JDWER1bUhRN3Awaw',
    };
    CreateFarmModel createFarmModel = CreateFarmModel(
        farmerId: int.parse(_farmerId),
        districtId: int.parse(_districtId),
        cropId: int.parse(_cropId),
        plantingDate: plantingDate,
        ploughingDate: ploughingDate,
        area: _area,
        coordinates: coordinates);

    String payload = createFarmModelToJson(createFarmModel);

    // String payload = jsonEncode(createFarmModel);

    var response =
        await client.post(url, headers: headers, body: payload).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return http.Response('Timed out', 500);
      },
    );
    var jsonString = response.body;

    if (response.statusCode == 201) {
      var er = jsonDecode(jsonString);
      var successmsg = er["message"];

      Get.snackbar("Message", successmsg,
          snackPosition: SnackPosition.BOTTOM,
          showProgressIndicator: true,
          isDismissible: true,
          backgroundColor: Colors.lightGreen,
          colorText: Colors.white,
          // messageText: const Text(
          //     "Please Go to Home Screen, click Admin Poartal to view your Farm Map"),
          duration: 5.seconds);
      Get.to(ViewFarmers());
      return CreateFarmModelFromJson(jsonString);
    } else {
      var er = jsonDecode(jsonString);

      var ermsg = er["message"];
      Get.snackbar("Error", ermsg,
          snackPosition: SnackPosition.BOTTOM,
          showProgressIndicator: true,
          isDismissible: true,
          backgroundColor: Colors.lightGreen,
          colorText: Colors.white,
          duration: 5.seconds);
      return CreateFarmModelFromJson(jsonString);
    }
  }
}
