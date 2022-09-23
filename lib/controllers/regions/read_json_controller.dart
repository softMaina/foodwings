import 'dart:convert';

import 'package:FoodWings/models/regions/region_model.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:get/get.dart';

class RegionDataController extends GetxController{

    RegionsModel gRegion = RegionsModel();
  List<RegionsModel> regionModelList = [];
    List<District> filteredDistrictList = [];

  Future<List<RegionsModel>> readJsonData() async {
    //read json file
    final jsondata = await rootBundle.rootBundle.loadString('assets/regions.json');

    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => RegionsModel.fromJson(e)).toList();
  }


  void filterDistrict(String regionId) {
    filteredDistrictList.clear();
    for (var i = 0; i < regionModelList.length; i++) {
      if (regionId == regionModelList[i].regionId) {
        if (regionModelList[i].districts != null ||
            regionModelList[i].districts!.isNotEmpty) {
          filteredDistrictList.addAll(regionModelList[i].districts!);
        } else {
          filteredDistrictList = [];
        }
      }
    }
    update();
  }


}