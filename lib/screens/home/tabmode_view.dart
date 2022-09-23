import 'package:FoodWings/screens/mapping/add_farm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../controllers/farm/crop_controller.dart';
import '../../controllers/farmers/farmer_controller.dart';
import '../farmer/add_famer.dart';
import '../farmer/view_farmer_screen.dart';
import 'web_view_admin_portal.dart';

GridView mobileGridView(BuildContext context) {
  FarmerController farmerController = FarmerController();

  Size size = MediaQuery.of(context).size;
  final Orientation orientation = MediaQuery.of(context).orientation;
  return GridView.count(
    mainAxisSpacing: 0.3,
    crossAxisCount: orientation == Orientation.portrait ? 2 : 2,
    children: [
      Card(
        elevation: 1,
        color: const Color(0xFF62B34D),
        borderOnForeground: true,
        margin: const EdgeInsets.all(10.0),
        shadowColor: Colors.black38,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: TextButton(
          onPressed: () => {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddFarmer()))
          },
          child: Column(
            children: const [
              Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: Text(
                  "Register Farmer",
                  style: TextStyle(
                      color: Color(0xFF1F4022),
                      fontSize: 17,
                      fontFamily: "Roboto",
                      fontStyle: FontStyle.normal),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.app_registration,
                  color: Color(0xFF1F4022),
                ),
              ),
            ],
          ),
        ),
      ),
      Card(
        elevation: 1,
        color: const Color(0xFF62B34D),
        borderOnForeground: true,
        margin: const EdgeInsets.all(10.0),
        shadowColor: Colors.black38,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: TextButton(
          onPressed: () => {
            farmerController.viewFarmers(),
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ViewFarmers()))
          },
          child: Column(
            children: const [
              Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: Text(
                  "View Farmer",
                  style: TextStyle(
                      color: Color(0xFF1F4022),
                      fontSize: 17,
                      fontFamily: "Roboto",
                      fontStyle: FontStyle.normal),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.app_registration,
                  color: Color(0xFF1F4022),
                ),
              ),
            ],
          ),
        ),
      ),
      Card(
        color: const Color(0xFF62B34D),
        borderOnForeground: true,
        shadowColor: Colors.black38,
        margin: const EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: TextButton(
          onPressed: () => {
            // Navigator.push(context,
            //     MaterialPageRoute(
            //         builder: (context) => AddFarmScreen()))
          },
          child: Column(
            children: const [
              Padding(
                padding: EdgeInsets.only(
                  top: 50.0,
                ),
                child: Text(
                  "Register Farm",
                  style: TextStyle(
                      color: Color(0xFF1F4022),
                      fontSize: 17,
                      fontFamily: "Roboto",
                      fontStyle: FontStyle.normal),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.add_box_outlined,
                  color: Color(0xFF1F4022),
                ),
              ),
            ],
          ),
        ),
      ),
      Card(
        color: const Color(0xFF62B34D),
        margin: const EdgeInsets.all(10.0),
        borderOnForeground: true,
        shadowColor: Colors.black38,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: TextButton(
          onPressed: () => {},
          child: Column(
            children: const [
              Padding(
                padding: EdgeInsets.only(
                  top: 50.0,
                ),
                child: Text(
                  "View Farm",
                  style: TextStyle(
                      color: Color(0xFF1F4022),
                      fontSize: 17,
                      fontFamily: "Roboto",
                      fontStyle: FontStyle.normal),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.view_carousel_outlined,
                  color: Color(0xFF1F4022),
                ),
              ),
            ],
          ),
        ),
      ),
      // Card(
      //   color: const Color(0xFF62B34D),
      //   margin: const EdgeInsets.all(10.0),
      //   borderOnForeground: true,
      //   shadowColor: Colors.black38,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(20.0),
      //   ),
      //   child: TextButton(
      //     onPressed: () => {
      //       Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //               builder: (context) => const RequestServiceScreen()))
      //     },
      //     child: Column(
      //       children: const [
      //         Padding(
      //           padding: EdgeInsets.only(top: 50.0),
      //           child: Text(
      //             "Request Service",
      //             style: TextStyle(
      //                 color: Color(0xFF1F4022),
      //                 fontSize: 17,
      //                 fontFamily: "Roboto",
      //                 fontStyle: FontStyle.normal),
      //           ),
      //         ),
      //         CircleAvatar(
      //           backgroundColor: Colors.white,
      //           child: Icon(
      //             Icons.request_page_outlined,
      //             color: Color(0xFF1F4022),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      // Card(
      //   color: const Color(0xFF62B34D),
      //   margin: const EdgeInsets.all(10.0),
      //   borderOnForeground: true,
      //   shadowColor: Colors.black38,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(20.0),
      //   ),
      //   child: TextButton(
      //     onPressed: () => {
      //       Navigator.push(context,
      //           MaterialPageRoute(builder: (context) => const ServiceScreen()))
      //     },
      //     child: Column(
      //       children: const [
      //         Padding(
      //           padding: EdgeInsets.only(top: 50.0),
      //           child: Text(
      //             "View Request",
      //             style: TextStyle(
      //                 color: Color(0xFF1F4022),
      //                 fontSize: 17,
      //                 fontFamily: "Roboto",
      //                 fontStyle: FontStyle.normal),
      //           ),
      //         ),
      //         SizedBox(
      //           height: 10,
      //         ),
      //         CircleAvatar(
      //           backgroundColor: Colors.white,
      //           child: Icon(
      //             Icons.view_carousel_outlined,
      //             color: Color(0xFF1F4022),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    ],
  );
}

SingleChildScrollView tabletView(
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
                        fontSize: size.height * 0.03,
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
                    child: Center(
                        child: Text(
                      "Register Farmer",
                      style: TextStyle(
                        color: Color(0xFF1F4022),
                        fontSize: size.height * 0.03,
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
            right: size.width * 0.05,
            bottom: size.width * 0.05,
          ),
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
                        fontSize: size.height * 0.03,
                      ),
                    ))),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:
                    _links.map((link) => _urlButton(context, link)).toList(),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Column tabMode(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  final Orientation orientation = MediaQuery.of(context).orientation;

  return Column(
    children: [
      Padding(
        padding: EdgeInsets.only(
            top: orientation == Orientation.portrait
                ? size.height * 0.05
                : size.height * 0.01),
        child: Center(
          child: SizedBox(
            width: orientation == Orientation.portrait ? 150 : 80,
            height: orientation == Orientation.portrait ? 150 : 80,
            child: Image.asset('assets/images/foodwing.PNG'),
          ),
        ),
      ),
      Expanded(
        child: mobileGridView(context),
      ),
    ],
  );
}

Column tabMode2(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  final Orientation orientation = MediaQuery.of(context).orientation;

  return Column(
    children: [
      Padding(
        padding: EdgeInsets.only(
            top: orientation == Orientation.portrait
                ? size.height * 0.0001
                : size.height * 0.01),
        child: Center(
          child: SizedBox(
            width: orientation == Orientation.portrait
                ? size.width * 0.5
                : size.width * 0.4,
            height: orientation == Orientation.portrait
                ? size.height * 0.4
                : size.height * 0.4,
            child: Image.asset('assets/images/foodwing.PNG'),
          ),
        ),
      ),
      Expanded(
        child: tabletView(context, orientation),
      ),
    ],
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
