import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../models/regions/region_model.dart';
import '../farmers/farmer_controller.dart';
import '../../utils/constants.dart';

class RegionController extends GetxController {
  List<District> districtModelList = [];
  List<District> filteredDistrictList = [];
  static GetStorage store = GetStorage();
  RegionsModel gRegion = RegionsModel();
  List<RegionsModel> regionModelList = [];
  FarmerController farmerController = Get.put(FarmerController());


  List fetchRegions() {
    return regions.toList();
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

  void filterRegionDistrict(String regionId, String districId) {
    District district = District();

    districtModelList.clear();
    for (var i = 0; i < regionModelList.length; i++) {
      var regionList = regionModelList[i];
      regionList.regionId = regionId;
      if (regionId == regionList.regionId) {
        districtModelList = regionModelList[i].districts!;
        for (var i = 0; i < districtModelList.length; i++) {
          var distList = districtModelList[i];
          if (districId == distList.districtId) {
            district = districtModelList[i];

            break;
          }
        }
      }
      String districtName = district.districtId ?? "No Districr name";
    }
  }
}
