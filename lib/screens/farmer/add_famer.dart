import 'dart:async';

import 'package:FoodWings/controllers/farm/crop_controller.dart';
import 'package:FoodWings/controllers/regions/region_contoller.dart';
import 'package:FoodWings/models/farmers/farmer.dart';
import 'package:FoodWings/network_services/farmer_service.dart';
import 'package:FoodWings/screens/farmer/add_farmer2.dart';
import 'package:FoodWings/screens/farmer/farmer_list.dart';
import 'package:FoodWings/screens/farmer/view_farmer_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../controllers/farmers/farmer_controller.dart';
import '../../controllers/farmers/syncronize.dart';
import '../../models/regions/region_model.dart';
import '../../network_services/checkNetwork.dart';
import '../../utils/app_bar.dart';
import '../../utils/dbhelper.dart';
import 'farmer_search_screen.dart';

class AddFarmer extends StatefulWidget {
  const AddFarmer({Key? key}) : super(key: key);

  @override
  _AddFarmerState createState() => _AddFarmerState();
}

class _AddFarmerState extends State<AddFarmer> {
  Timer? _timer;
  final FarmerController farmerController = Get.put(FarmerController());
  TextEditingController farmerNameController = TextEditingController();
  TextEditingController msisdnContrller = TextEditingController();
  TextEditingController districtIdController = TextEditingController();
  TextEditingController areaCrontroller = TextEditingController();
  final RegionController regionController = Get.put(RegionController());
  final CropController cropController = Get.put(CropController());
  DbHelper dbHelper = DbHelper();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  District? _district;
  RegionsModel? _region;
  String? selectedDistrictId;
  String? _districtName;
  String? _farmerName;
  String? _communtName;
  String? _regionName;
  late List list;
  bool loading = true;

  Future faremerList() async {
    list = await CheckConnection().fetchFarmer();
    setState(() {
      loading = false;
    });
    //print(list);
  }

  Future isInteret(BuildContext context) async {
    await SyncronizationData.isInternet().then((connection) {
      if (connection) {
        if (kDebugMode) {
          print("Internet connection abailale");
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("No Internet")));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    faremerList();
    isInteret(context);
    dbHelper.openDb();
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer!.cancel();
      }
    });
  }

  Future syncToMysql() async {
    await SyncronizationData().fetchAllFarmers().then((farmerList) async {
      EasyLoading.show(status: 'Dont close app. we are sync...');
      await SyncronizationData().saveToMysqlWith(farmerList);
      EasyLoading.showSuccess('Successfully save to mysql');
    });
  }

  Widget _nameBuild() {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.fromLTRB(size.width * 0.05, size.height * 0.01,
          size.width * 0.05, size.height * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              "Farmer Name",
              style: TextStyle(
                color: Color(0xFF1F4022),
              ),
            ),
          ),
          Container(
            width: size.width * 0.9,
            height: size.height * 0.08,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: TextFormField(
              controller: farmerNameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      width: 2,
                      style: BorderStyle.none,
                    ),
                  ),
                  hintText: "Ndivoi...",

                  // fillColor: Color(0xEFF9FAFB),
                  filled: true,
                  labelStyle:
                      const TextStyle(fontSize: 12, color: Color(0xFF888888))),
              // onChanged: (_farmerName) {
              //   _farmerName = farmerNameController.text;

              //   print("This is Farmer Name ${_regionName}");
              // },
            ),
          ),
        ],
      ),
    );
  }

  Widget _phoneBuild() {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.fromLTRB(size.width * 0.05, size.height * 0.01,
          size.width * 0.05, size.height * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              "Phone Number",
              style: TextStyle(
                color: Color(0xFF1F4022),
              ),
            ),
          ),
          Container(
            width: size.width * 0.9,
            height: size.height * 0.08,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: TextFormField(
              controller: msisdnContrller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      width: 2,
                      style: BorderStyle.none,
                    ),
                  ),
                  hintText: "2337587459...",
                  filled: true,
                  labelStyle:
                      const TextStyle(fontSize: 12, color: Color(0xFF888888))),
            ),
          ),
        ],
      ),
    );
  }

  Widget _areaBuild() {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.fromLTRB(size.width * 0.05, size.height * 0.01,
          size.width * 0.05, size.height * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "Community Name",
              style: TextStyle(
                color: Color(0xFF1F4022),
              ),
            ),
          ),
          Container(
            width: size.width * 0.9,
            height: size.height * 0.08,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: TextFormField(
              controller: areaCrontroller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      width: 2,
                      style: BorderStyle.none,
                    ),
                  ),
                  hintText: "Accra community.....",
                  filled: true,
                  labelStyle:
                      const TextStyle(fontSize: 12, color: Color(0xFF888888))),
              onChanged: (_communtName) {
                _communtName = areaCrontroller.text;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _regionBuild() {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.fromLTRB(size.width * 0.05, size.height * 0.01,
          size.width * 0.05, size.height * 0.01),
      child: GetBuilder<RegionController>(
          init: RegionController(),
          builder: (_) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Text(
                    "Region Name",
                    style: TextStyle(
                      color: Color(0xFF1F4022),
                    ),
                  ),
                ),
                Container(
                  width: size.width * 0.9,
                  height: size.height * 0.08,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<RegionsModel>(
                        value: _region,
                        hint: const Padding(
                          padding: EdgeInsets.fromLTRB(22.0, 0, 0, 0),
                          child: Text(
                            "Select Region....",
                            style: TextStyle(),
                          ),
                        ),
                        items: _.regionModelList
                            .map<DropdownMenuItem<RegionsModel>>(
                                (RegionsModel value) {
                          return DropdownMenuItem<RegionsModel>(
                            value: value,
                            child: Text(value.regionName!),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedDistrictId = value!.regionId;
                            _regionName = value.regionName;
                            _region = value;
                            _.filterDistrict(selectedDistrictId!);
                          });
                        }),
                  ),
                ),
              ],
            );
          }),
    );
  }

  Widget _districtBuild() {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.fromLTRB(size.width * 0.05, size.height * 0.01,
          size.width * 0.05, size.height * 0.0),
      child: GetBuilder<RegionController>(
          init: RegionController(),
          builder: (_) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Text(
                    "District Name",
                    style: TextStyle(
                      color: Color(0xFF1F4022),
                    ),
                  ),
                ),
                Container(
                  width: size.width * 0.9,
                  height: size.height * 0.08,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<District>(
                        value: _district,
                        hint: const Padding(
                          padding: EdgeInsets.fromLTRB(22.0, 0, 0, 0),
                          child: Text(
                            "Select District....",
                            style: TextStyle(),
                          ),
                        ),
                        items: _.filteredDistrictList
                            .map<DropdownMenuItem<District>>((District value) {
                          return DropdownMenuItem<District>(
                            value: value,
                            child: Text(value.districtName!),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _district = value;
                            selectedDistrictId = value!.districtId;
                            _districtName = value.districtName;
                          });
                        }),
                  ),
                ),
              ],
            );
          }),
    );
  }

  Widget _createFarmerButton() {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
          top: size.height * 0.03,
          left: size.width * 0.05,
          bottom: size.height * 0.05),
      child: Container(
        height: size.height * 0.07,
        width: size.width * 0.7,
        decoration: const BoxDecoration(
          color: Color(0xFFC29626),
        ),
        child: TextButton(
          onPressed: () => {
            _addFarmerButton(),
          },
          child: Text(
            "Save",
            style: TextStyle(
              fontSize: size.height * 0.03,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (regionController.regionModelList.isEmpty) {
      regionController.fetchRegions();
    }
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: buildAppBar(
          IconButton(
            onPressed: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ViewFarmers())),
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.green,
              //icon bg color
              size: size.height * 0.03,
            ),
          ),
          size,
          'Add Farmer'
        ),
        body: SingleChildScrollView(
          child: SafeArea(
              child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(
                  size.width * 0.2,
                  size.height * 0.05,
                  size.width * 0.15,
                  size.height * 0.05,
                ),
                child: Text(
                  'Enter Farmer Details',
                  style: TextStyle(
                    fontSize: size.height * 0.02,
                    color: Color(0xFF1F4022),
                  ),
                ),
              ),
              _nameBuild(),
              _phoneBuild(),
              _areaBuild(),
              _regionBuild(),
              _districtBuild(),
              _createFarmerButton()
            ],
          )),
        ));
  }

  _gotonetherPageButton() {
    if (farmerNameController.text.isEmpty ||
        msisdnContrller.text.isEmpty ||
        areaCrontroller.text.isEmpty ||
        _districtName!.isEmpty ||
        _regionName!.isEmpty) {
      Get.snackbar("Error", "Please Ensure You have Filled all fields",
          snackPosition: SnackPosition.BOTTOM,
          showProgressIndicator: true,
          isDismissible: true,
          backgroundColor: Colors.lightGreen,
          colorText: Colors.white,
          duration: 5.seconds);
    } else {
      cropController.viewCrops();

      Get.to(AddFarme2Screen(
        farmerName: farmerNameController.text,
        msisdn: msisdnContrller.text,
        communityName: areaCrontroller.text,
        districtName: _districtName!,
        districtId: selectedDistrictId!,
        regionName: _regionName!,
      ));
    }
  }

  _syncFarmerButton(BuildContext context) async {
    await SyncronizationData.isInternet().then((value) => (connection) {
          if (connection) {
            syncToMysql();
            if (kDebugMode) {
              print("Internet Connection Available");
            }
          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("No Internet")));
          }
        });
  }

  //save to sqflite
  _addFarmerButton() async {
    Farmer farmer = Farmer(farmerNameController.text, msisdnContrller.text,
        int.parse(selectedDistrictId!), areaCrontroller.text);

    bool connected = await CheckConnection.inInternet();
    if(connected){
      // post online
      FarmerService s = FarmerService();
      s.addFarmer(farmer);
    }else{
      dbHelper.insertFarmer(farmer);
      dbHelper.getFarmers();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>   ViewFarmers()),
      );
    }
  }
}
