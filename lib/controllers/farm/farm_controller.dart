import 'dart:convert';
import 'package:FoodWings/network_services/farm_services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../models/farm/farm_model.dart';

class CreatFarmController extends GetxController {
  static GetStorage store = GetStorage();
  static String auth = store.read("auth");

  Future<void> createFarm(
      String farmerId,
      String districtId,
      String cropid,
      DateTime plantingDate,
      DateTime ploughingDate,
      String area,
      List<Coordinate> coordinates) async {
    var response = await FarmService.createFarmService(farmerId, districtId,
        cropid, plantingDate, ploughingDate, area, coordinates);

    if (response != null) {
      if (response[1] == 201) {
        var jsonString = jsonDecode(response);
        return jsonString;
      }
    } else {}
  }
}
