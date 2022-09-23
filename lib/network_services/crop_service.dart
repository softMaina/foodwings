import 'dart:convert';

import 'package:FoodWings/models/farm/crop_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../models/misc/error_message.dart';
import 'network_handler.dart';

class CropService {
  static var client = http.Client();
  static GetStorage store = GetStorage();
  static String auth = store.read("auth");

  static Future viewCropService() async {
    var url = NetWorkHandler.buildUrl("crop/view");

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Accept': 'application/json',
      'AUTH': 'blhGVzMwcWFLOFRrUUJXdTZZN0JXMklKRG1VSEhuTFU3OGxMeVE4S2pQaEx3OHBuQ00yU1FyeU5DQmdXWFdGWkdPV3Q2ays2L0JDd21HQzVlemJHM2Yyb0g4STNtWkcvUzFKZ1ZVaytIczU5cm5TUTFtL0d5Yk5YMCs2V1FsTmY3T3BxN1Z4Sm8vVDJxZGZkcE1uWjA3ZUF3T1Z4SkI4Um5kQjlKWit5WllsYlNjOUp3MHRMWGs4aVIxTGRuWXJRSXN4bVhxbk5MWHJPeUM3VkRzb0VSamRFdE9XbE5rdndqK3FGVjNiOE1xMUtJWDFKL1pjT1JDWER1bUhRN3Awaw',
    };
    var response = await client.post(url, headers: headers);
    var jsonString = response.body;

    if (response.statusCode == 200) {
      var data = cropModelFromJson(response.body);

      return data;
    } else {
      var data = cropModelFromJson(response.body);
      var errormsg = jsonDecode(data.toString());
      Get.snackbar("Error", errormsg);
      return [erroMessageFromJson(jsonString), response.statusCode];
    }
  }
}
