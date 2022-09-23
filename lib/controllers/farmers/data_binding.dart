import 'package:get/get.dart';

import 'farmer_controller.dart';

class DataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FarmerController());
  }
}
