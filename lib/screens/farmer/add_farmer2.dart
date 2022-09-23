import 'dart:async';
import 'dart:ui';

import 'package:FoodWings/controllers/farmers/syncronize.dart';
import 'package:FoodWings/models/farmers/create_farmer.dart';
import 'package:FoodWings/network_services/checkNetwork.dart';
import 'package:FoodWings/screens/farmer/take_a_photo.dart';
import 'package:FoodWings/screens/home/home_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/farm/crop_controller.dart';
import '../../controllers/farmers/farmer_controller.dart';
import '../../utils/app_bar.dart';
import '../mapping/add_farm2.dart';
import 'view_farmer_screen.dart';

class AddFarme2Screen extends StatefulWidget {
  final String farmerName;
  final String msisdn;
  final String communityName;
  final String districtName;
  final String districtId;
  final String regionName;
  const AddFarme2Screen(
      {Key? key,
      required this.farmerName,
      required this.msisdn,
      required this.communityName,
      required this.districtId,
      required this.districtName,
      required this.regionName})
      : super(key: key);

  @override
  _AddFarme2ScreenState createState() => _AddFarme2ScreenState();
}

class _AddFarme2ScreenState extends State<AddFarme2Screen> {
  final FarmerController farmerController = Get.put(FarmerController());
  TextEditingController _emailController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _idNumberController = TextEditingController();
  TextEditingController _doBController = TextEditingController();
  TextEditingController _languageController = TextEditingController();
  final CropController cropController = Get.put(CropController());
  late Timer _timer;
  final List<String> _genderList = ["Male", "Female", "Others"];
  final List<String> _typeOfID = ["Ghana Card", "Voter's ID", "NHIS"];

  @override
  void initState() {
    _doBController.text = ""; //set the initial value of text field
    super.initState();
  }

  String? _selectedG;
  String? _selectedToID;

  Widget _doBBuild() {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.fromLTRB(size.width * 0.05, size.height * 0.01,
          size.width * 0.05, size.height * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "Date of Birth",
              style: TextStyle(
                fontSize: size.height * 0.02,
                color: Color(0xFF1F4022),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Colors.black45,
                  offset: Offset(2.5, 5.5),
                  blurRadius: 12.0,
                )
              ],
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: TextFormField(
              controller: _doBController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),

                hintText: "02-02-1994",

                // fillColor: Color(0xEFF9FAFB),
                filled: true,
                labelStyle: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF888888),
                ),
              ),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1940),
                    lastDate: DateTime(2101));

                if (pickedDate != null) {
                  print(pickedDate);
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  print(formattedDate);
                  setState(() {
                    _doBController.text = formattedDate;
                  });
                } else {
                  print("Date is not selected");
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _genderBuildList() {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.fromLTRB(size.width * 0.05, size.height * 0.00,
          size.width * 0.05, size.height * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "Gender",
              style: TextStyle(
                fontSize: size.height * 0.02,
                color: Color(0xFF1F4022),
              ),
            ),
          ),
          Container(
            width: size.width * 0.9,
            height: size.height * 0.08,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Colors.black45,
                  offset: Offset(2.5, 5.5),
                  blurRadius: 12.0,
                )
              ],
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                  value: _selectedG,
                  hint: const Padding(
                    padding: EdgeInsets.fromLTRB(22.0, 0, 0, 0),
                    child: Text(
                      "Select Gender....",
                      style: TextStyle(),
                    ),
                  ),
                  items: _genderList.map((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedG = value;
                    });
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _typeOfIdBuild() {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.fromLTRB(size.width * 0.05, size.height * 0.00,
          size.width * 0.05, size.height * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "Type of ID",
              style: TextStyle(
                fontSize: size.height * 0.02,
                color: Color(0xFF1F4022),
              ),
            ),
          ),
          Container(
            width: size.width * 0.9,
            height: size.height * 0.08,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Colors.black45,
                  offset: Offset(2.5, 5.5),
                  blurRadius: 12.0,
                )
              ],
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                  value: _selectedToID,
                  hint: const Padding(
                    padding: EdgeInsets.fromLTRB(22.0, 0, 0, 0),
                    child: Text(
                      "Select Type of ID....",
                      style: TextStyle(),
                    ),
                  ),
                  items: _typeOfID.map((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedToID = value;
                    });
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _idNumberBuild() {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.fromLTRB(size.width * 0.05, size.height * 0.04,
          size.width * 0.05, size.height * 0.00),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "ID Number",
              style: TextStyle(
                fontSize: size.height * 0.02,
                color: Color(0xFF1F4022),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Colors.black45,
                  offset: Offset(2.5, 5.5),
                  blurRadius: 12.0,
                )
              ],
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: TextFormField(
              controller: _idNumberController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  hintText: "6473934723",

                  // fillColor: Color(0xEFF9FAFB),
                  filled: true,
                  labelStyle:
                      const TextStyle(fontSize: 12, color: Color(0xFF888888))),
            ),
          ),
        ],
      ),
    );
  }

  Widget _languageBuild() {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.fromLTRB(size.width * 0.05, size.height * 0.04,
          size.width * 0.05, size.height * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "Language",
              style: TextStyle(
                fontSize: size.height * 0.02,
                color: Color(0xFF1F4022),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Colors.black45,
                  offset: Offset(2.5, 5.5),
                  blurRadius: 12.0,
                )
              ],
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: TextFormField(
              controller: _languageController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  hintText: "language",

                  // fillColor: Color(0xEFF9FAFB),
                  filled: true,
                  labelStyle:
                      const TextStyle(fontSize: 12, color: Color(0xFF888888))),
            ),
          ),
        ],
      ),
    );
  }

  Widget _addPhotoButton() {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
          top: size.height * 0.03,
          left: size.width * 0.05,
          bottom: size.height * 0.05),
      child: Container(
        height: size.height * 0.07,
        width: size.width * 0.7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFF5AB2C),
              offset: Offset(2.5, 5.5),
              blurRadius: 5.0,
            ),
          ],
          color: const Color(0xFFC29626),
        ),
        child: TextButton(
          onPressed: () => {
            _checkfields(),
            // farmerController.creatFarmer(
            //     farmerNameController.text,
            //     msisdnContrller.text,
            //     areaCrontroller.text,
            //     selectedDistrictId!),

            // Get.to(AddFarmer()),
            // print("Farmer Name ${farmerNameController.text}"),
            // print("Farmer District ${districtIdController.text}"),
            // print("Farmer Ccommunity ${areaCrontroller.text}"),
            // Get.snackbar("Creating Farmer", "Fammer is being created")
          },
          child: Text(
            "Add Farmer Photo",
            style: TextStyle(
              fontSize: size.height * 0.02,
              color: const Color(0xFF1F4022),
            ),
          ),
        ),
      ),
    );
  }

  _checkfields() {
    if (_doBController.text.isEmpty ||
        _selectedG == null ||
        _selectedToID == null ||
        _idNumberController.text.isEmpty) {
      Get.snackbar("Error", "Please Ensure You have Filled all fields",
          snackPosition: SnackPosition.BOTTOM,
          showProgressIndicator: true,
          isDismissible: true,
          backgroundColor: Colors.lightGreen,
          colorText: Colors.white,
          duration: 5.seconds);
    } else {
      Get.to(TakeAphoto(
        communityName: widget.communityName,
        districtName: widget.districtName,
        farmerName: widget.farmerName,
        districtId: widget.districtId,
        msisdn: widget.msisdn,
        lannguage: _languageController.text,
        gender: _selectedG!,
        typofId: _selectedToID!,
        dateOfBirth: _doBController.text,
        idNo: _idNumberController.text,
        reigionName: widget.regionName,
      ));
    }
  }
  Future isInteret() async {
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
  Widget build(BuildContext context) {
    farmerController.viewFarmers();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(
        IconButton(
          onPressed: () => {
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen())),
          },
          icon: Icon(
            Icons.arrow_back,
            color: const Color(0xFF1F4022),
            //icon bg color
            size: size.height * 0.03,
          ),
        ),
        size,
        'Add Farmer'
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(
                  size.width * 0.2,
                  size.height * 0.02,
                  size.width * 0.15,
                  size.height * 0.05,
                ),
                child: Text(
                  'Enter Farmer Details',
                  style: TextStyle(
                    fontSize: size.height * 0.03,
                    color: Color(0xFF1F4022),
                  ),
                ),
              ),
              _doBBuild(),
              _genderBuildList(),
              _typeOfIdBuild(),
              _idNumberBuild(),
              _languageBuild(),
              _addPhotoButton(),
              //_createFarmerButton()
            ],
          ),
        )),
      ),
    );
  }
}
