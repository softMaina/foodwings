import 'package:FoodWings/controllers/regions/region_contoller.dart';
import 'package:FoodWings/utils/secret.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../../models/farmers/view_farmer.dart';
import '../../models/regions/region_model.dart';
import '../../network_services/farmer_service.dart';

class FarmerController extends GetxController {
  static GetStorage store = GetStorage();

  ViewFarmerModel vFModel = ViewFarmerModel();
  List<ViewFarmerModel> vFModelList = [];
  List<RegionsModel> regionModelList = [];
  Farm farms = Farm();
  List<Farm> farmList = [];

  District district = District();

  int distId = Secrets.districtId;

  static var client = http.Client();

  Future<void> creatFarmer(String _farmerName, String _msisdn, String _area,
      String _districtId) async {
    final response = await FarmerService.createFamerService(
        _farmerName, _msisdn, _area, _districtId);
    if (response[1] == 200) {
      if (response[0]) {}
    }
  }

  Future<void> viewFarmers() async {
    var response = await FarmerService.viewFarmerService();

    try {
      if (response != null) {
        if (response[1] == 200) {
          print("Response Code ${response[1]}");

          vFModelList = response[0];
          print("Length of the farmers ${vFModelList.length}");
          if (vFModelList == null) {
            print("No regions");
          } else {
            farmList = vFModel.farms!;
            print("Yes Farmers");
          }

          update();
        }
      }
    } catch (e) {}
  }

  void filterFarms() {
    farmList.clear();
    for (var i = 0; i < vFModelList.length; i++) {
      var farmL = vFModelList[i];
      farmList = farmL.farms!;
    }
  }

  void sumFarmerandTheirFarms() {
    for (var i = 0; i < vFModelList.length; i++) {
      var farmers = vFModelList[i];
      var farmerId = farmers.id;
      for (var i = 0; i < farmerId!.length; i++) {}
      print("FarmerIds" + farmerId);
    }
  }

  String regionName = "";

  Future<String> getRegion(String regionId) async {
    List<RegionsModel> regions = [];
    String regionName = '';
    RegionController regionController = RegionController();
    if (regionController.regionModelList.isNotEmpty) {
      regions = regionController.regionModelList;
    } else {
      regions =  [];
    }

    if (regions.isNotEmpty) {
      for (var i = 0; i < regions.length; i++) {
        if (regions[i].regionId == regionId) {
          regionName = regions[i].regionName!;
        }
      }
    }
    return regionName;
  }
}
