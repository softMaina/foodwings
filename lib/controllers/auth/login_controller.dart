import 'package:FoodWings/controllers/farmers/farmer_controller.dart';
import 'package:FoodWings/models/auth/login_response.dart';
import 'package:FoodWings/network_services/login_service.dart';
import 'package:FoodWings/screens/home/home_screen.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  FarmerController farmerController = FarmerController();
  List<LoginResponse> lGModelList = [];

  Future<void> login(String username, String password) async {
    final response = await LoginService.login(username, password);

    try {
      if (response != null) {
        if (response[1] == 200) {
          Get.offAll(const HomeScreen());
          lGModelList = response[0];
          farmerController.viewFarmers();

          update();
        }
      }
    } catch (e) {}
  }
}
