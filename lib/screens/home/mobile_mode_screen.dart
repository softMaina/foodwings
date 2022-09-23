import 'package:FoodWings/screens/farmer/add_farmer2.dart';
import 'package:FoodWings/screens/home/web_view_admin_portal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../controllers/farm/crop_controller.dart';
import '../../controllers/farmers/farmer_controller.dart';
import '../farmer/add_famer.dart';
import '../farmer/view_farmer_screen.dart';
import '../mapping/add_farm.dart';

SingleChildScrollView mobileView(
    BuildContext context, Orientation orientation) {
  final _links = ['https://camellabs.com'];
  FarmerController farmerController = FarmerController();
  Size size = MediaQuery.of(context).size;
  final Orientation orientation = MediaQuery.of(context).orientation;
  return SingleChildScrollView(
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: orientation == Orientation.portrait
                  ? size.height * 0.05
                  : size.height * 0.05),
          child: Center(
            child: SizedBox(
              width: 200,
              height: 200,
              child: Image.asset('assets/images/foodwing.PNG'),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: size.height * 0.05,
              left: size.width * 0.05,
              right: size.width * 0.05),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: const Color(0xFF62B34D)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: orientation == Orientation.portrait
                          ? size.width * 0.3
                          : size.width * 0.3),
                  child: TextButton(
                    onPressed: () => {Get.to(ViewFarmers())},
                    child: const Text(
                      "View Farmer",
                      style: TextStyle(
                          color: Color(0xFF1F4022),
                          fontSize: 17,
                          fontFamily: "Roboto",
                          fontStyle: FontStyle.normal),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: size.height * 0.02,
              left: size.width * 0.03,
              right: size.width * 0.05),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: const Color(0xFF62B34D)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: orientation == Orientation.portrait
                          ? size.width * 0.3
                          : size.width * 0.2),
                  child: TextButton(
                    onPressed: () => {
                      // farmerController.viewFarmers(),
                      print("View Farmer button Pusshed"),
                      Get.to(const AddFarmer())
                    },
                    child: const Text(
                      "Register Farmer",
                      style: TextStyle(
                          color: Color(0xFF1F4022),
                          fontSize: 17,
                          fontFamily: "Roboto",
                          fontStyle: FontStyle.normal),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: size.height * 0.02,
              left: size.width * 0.05,
              right: size.width * 0.05),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: const Color(0xFF62B34D)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: orientation == Orientation.portrait
                          ? size.width * 0.3
                          : size.width * 0.3),
                  child: TextButton(
                    onPressed: () => {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => AddFarmScreen()))
                    },
                    child: const Text(
                      "Map Farm",
                      style: TextStyle(
                          color: Color(0xFF1F4022),
                          fontSize: 17,
                          fontFamily: "Roboto",
                          fontStyle: FontStyle.normal),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: size.height * 0.02,
              left: size.width * 0.01,
              right: size.width * 0.05),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: const Color(0xFF62B34D)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: orientation == Orientation.portrait
                          ? size.width * 0.3
                          : size.width * 0.1),
                  child: TextButton(
                    onPressed: () => {},
                    child: const Text(
                      "View Mapped Farms",
                      style: TextStyle(
                          color: Color(0xFF1F4022),
                          fontSize: 17,
                          fontFamily: "Roboto",
                          fontStyle: FontStyle.normal),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

SingleChildScrollView mobileView2(
    BuildContext context, Orientation orientation) {
  GetStorage store = GetStorage();
  var token = store.read("auth");
  final _links = ['https://food-wings.com/login?token=${token}'];
  FarmerController farmerController = FarmerController();
  final CropController cropController = Get.put(CropController());
  Size size = MediaQuery.of(context).size;
  final Orientation orientation = MediaQuery.of(context).orientation;
  return SingleChildScrollView(
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: orientation == Orientation.portrait
                  ? size.height * 0.05
                  : size.height * 0.05),
          child: Center(
            child: SizedBox(
              width: 200,
              height: 200,
              child: Image.asset('assets/images/foodwing.PNG'),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: size.height * 0.06,
              left: size.width * 0.03,
              right: size.width * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: size.height * 0.15,
                width: size.width * 0.4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    // backgroundBlendMode: BlendMode.overlay,
                    color: const Color(0xFFC29626),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xFFF5AB2C),
                        offset: Offset(2.5, 5.5),
                        blurRadius: 5.0,
                      )
                    ]),
                child: TextButton(
                    onPressed: () => {Get.to(ViewFarmers())},
                    child: Center(
                        child: Text(
                      "View Farmers",
                      style: TextStyle(
                        color: Color(0xFF1F4022),
                        fontSize: size.height * 0.027,
                      ),
                    ))),
              ),
              Container(
                height: size.height * 0.15,
                width: size.width * 0.4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    // backgroundBlendMode: BlendMode.overlay,
                    color: const Color(0xFFC29626),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xFFF5AB2C),
                        offset: Offset(2.5, 5.5),
                        blurRadius: 5.0,
                      )
                    ]),
                child: TextButton(
                    onPressed: () => {Get.to(const AddFarmer())},
                    child: Padding(
                        padding: EdgeInsets.only(left: size.width * 0.07),
                        child: Text(
                          "Register Farmer",
                          style: TextStyle(
                            color: Color(0xFF1F4022),
                            fontSize: size.height * 0.027,
                          ),
                        ))),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: size.height * 0.05,
              left: size.width * 0.03,
              right: size.width * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: size.height * 0.15,
                width: size.width * 0.4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    // backgroundBlendMode: BlendMode.overlay,
                    color: const Color(0xFFC29626),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xFFF5AB2C),
                        offset: Offset(2.5, 5.5),
                        blurRadius: 5.0,
                      )
                    ]),
                child: TextButton(
                    onPressed: () =>
                        {
                          // Get.to(AddFarmScreen()), cropController.viewCrops()
                        },
                    child: Center(
                        child: Text(
                      "Map Farm",
                      style: TextStyle(
                        color: Color(0xFF1F4022),
                        fontSize: size.height * 0.027,
                      ),
                    ))),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: size.height * 0.0,
                    left: size.width * 0.01,
                    right: size.width * 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:
                      _links.map((link) => _urlButton(context, link)).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _urlButton(BuildContext context, String url) {
  Size size = MediaQuery.of(context).size;
  return Container(
    height: size.height * 0.15,
    width: size.width * 0.4,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        // backgroundBlendMode: BlendMode.overlay,
        color: const Color(0xFFC29626),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFF5AB2C),
            offset: Offset(2.5, 5.5),
            blurRadius: 5.0,
          )
        ]),
    child: TextButton(
        onPressed: () => _handleURLButtonPress(context, url),
        child: Padding(
            padding: EdgeInsets.only(left: size.width * 0.02),
            child: Text(
              "Admin Portal",
              style: TextStyle(
                color: Color(0xFF1F4022),
                fontSize: size.height * 0.027,
              ),
            ))),
  );
}

void _handleURLButtonPress(BuildContext context, String url) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => WebViewContainer(url)));
}
