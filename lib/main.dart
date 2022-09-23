// @dart=2.9
import 'package:FoodWings/foodwingsTheme.dart';
import 'package:FoodWings/network_services/databaseheleper.dart';
import 'package:FoodWings/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'controllers/farmers/farmer_controller.dart';

final FarmerController crFarmerCtrl = Get.put(FarmerController());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await SqfliteDatabaseHelper.instance.db;
  runApp(const MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
  //..customAnimation = CustomAnimation();
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'FoodWings By Bayer',
      theme: theme,
      home: const LoginPage(),
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
    );
  }
}
