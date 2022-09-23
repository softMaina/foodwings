import 'package:FoodWings/controllers/regions/region_contoller.dart';
import 'package:FoodWings/screens/farm/view_farm.dart';
import 'package:FoodWings/screens/home/Home.dart';
import 'package:FoodWings/screens/home/home_screen.dart';
import 'package:FoodWings/screens/mapping/add_farm.dart';
import 'package:FoodWings/utils/app_bar.dart';
import 'package:FoodWings/utils/dbhelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/farmers/farmer_controller.dart';
import 'add_famer.dart';

class ViewFarmers extends StatefulWidget {
  ViewFarmers({Key? key}) : super(key: key);

  @override
  State<ViewFarmers> createState() => _ViewFarmersState();
}

class _ViewFarmersState extends State<ViewFarmers> {
  DbHelper dbHelper = DbHelper();

  final FarmerController farmerController = Get.put(FarmerController());
  final RegionController regionController = Get.put(RegionController());

  @override
  Widget build(BuildContext context) {
    dbHelper.getFarmerAndFarms();
    if (farmerController.vFModelList.isEmpty) {
      farmerController.viewFarmers();
    }
    Size size = MediaQuery.of(context).size;
    _farmerStyles() {
      GoogleFonts.poppins(
        color: const Color(0xFF1F4022),
        fontSize: size.width * 0.07,
        fontWeight: FontWeight.w400,
      );
    }

    return Scaffold(
      appBar: buildAppBar(
          TextButton(
            onPressed: () => {Get.to(const HomeScreen())},
            child: Icon(
              Icons.arrow_left,
              color: const Color(0XFF009783), //icon bg color
              size: size.height * 0.04,
            ),
          ),
          size,
          'Farmers'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddFarmer()));
        },
        backgroundColor: Colors.amber,
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: Container(
          height: size.height,
          width: size.height,
          color: const Color(0xfff8f8f8),
          child: SafeArea(
            child: Padding(
                padding: EdgeInsets.only(top: size.height * 0.01),
                child: SizedBox(
                  height: size.height * 0.9,
                  width: size.width,
                  child: GetBuilder<FarmerController>(
                      init: FarmerController(),
                      builder: (data) {
                        return ListView.builder(
                            itemCount: data.vFModelList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                elevation: 0,
                                clipBehavior: Clip.antiAlias,
                                child: InkWell(
                                  onTap: () => {
                                    Get.to(ViewFarm(
                                        farmer: data.vFModelList[index])),
                                    Colors.grey.withOpacity(0.5),
                                  },
                                  child: SizedBox(
                                    height: size.height * 0.15,
                                    width: size.width * 0.8,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          top: 10,
                                          width: size.width * 0.9,
                                          left: 10,
                                          child: Text(
                                            "Name: " +
                                                data.vFModelList[index]
                                                    .farmerName!,
                                            style: const TextStyle(
                                                fontSize: 24,
                                                color: Colors.amber),
                                          ),
                                        ),
                                        Positioned(
                                          top: 35,
                                          width: size.width * 0.9,
                                          left: 10,
                                          child: Text(
                                            "Phone Number: " +
                                                data.vFModelList[index].msisdn!,
                                            style: _farmerStyles(),
                                          ),
                                        ),
                                        Positioned(
                                            top: 55,
                                            width: size.width * 0.9,
                                            left: 10,
                                            child: Text(
                                                "Area : ${data.vFModelList[index].area ?? " no area"}")),
                                        Positioned(
                                            right: 0,
                                            bottom: 0,
                                            child: TextButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            AddFarmScreen(
                                                              farmerName: data
                                                                  .vFModelList[
                                                                      index]
                                                                  .farmerName!,
                                                              farmerId: int.parse(data.vFModelList[index].id!),
                                                            )));
                                              },
                                              child: const Text('Add Farm',
                                                  style: TextStyle(
                                                      color: Colors.green)),
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      }),
                )),
          ),
        ),
      ),
    );
  }
}
