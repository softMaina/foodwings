import 'package:FoodWings/models/farm/crop_model.dart';
import 'package:FoodWings/network_services/crop_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CropController extends GetxController {
  static GetStorage store = GetStorage();
  static String auth = store.read("auth");
  CropModel cropModel = CropModel();
  List<Datum> croptypes = [];
  List crops = [];

  Future<void> viewCrops() async {
    CropModel response = await CropService.viewCropService();
    try {
      if (response != null) {
        if (response.status == 200) {
          croptypes = response.data!;
          crops = croptypes;
        }
        if (croptypes.isEmpty) {
          print("No Crops");
        } else {
          croptypes = cropModel.data!;
        }
      } else {}
    } catch (e) {}
  }

  getCrops(){
    return crops;
  }


}
