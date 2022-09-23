import 'dart:io';

import 'package:FoodWings/screens/farmer/view_farmer_screen.dart';
import 'package:FoodWings/screens/home/home_screen.dart';
import 'package:FoodWings/widgets/image_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import '../../controllers/farmers/farmer_controller.dart';
import '../../controllers/farmers/syncronize.dart';
import '../../models/farmers/create_farmer.dart';
import '../../network_services/checkNetwork.dart';
import '../../utils/app_bar.dart';
import '../mapping/add_farm2.dart';

class TakeAphoto extends StatefulWidget {
  final String farmerName;
  final String gender;
  final String msisdn;
  final String dateOfBirth;
  final String typofId;
  final String idNo;
  final String communityName;
  final String districtName;
  final String reigionName;
  final String districtId;
  final String lannguage;

  const TakeAphoto(
      {Key? key,
      required this.farmerName,
      required this.msisdn,
      required this.communityName,
      required this.districtName,
      required this.districtId,
      required this.gender,
      required this.dateOfBirth,
      required this.typofId,
      required this.idNo,
      required this.reigionName,
      required this.lannguage})
      : super(key: key);

  @override
  State<TakeAphoto> createState() => _TakeAphotoState();
}

class _TakeAphotoState extends State<TakeAphoto> {
  final FarmerController farmerController = Get.put(FarmerController());
  bool _checkbox = false;
  bool _checkboxListTile = false;
  File? image;

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/ $name');
    return File(imagePath).copy(image.path);
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      // final imageTemporary = File(image.path);
      final imagePermanent = await saveImagePermanently(image.path);

      setState(() {
        this.image = imagePermanent;
      });
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  Widget _buildButton(
      {required String tilte,
      required IconData icon,
      required VoidCallback onCliked}) {
    Size size = MediaQuery.of(this.context).size;
    return Container(
      height: size.height * 0.05,
      width: size.width * 0.5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
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
          onPressed: onCliked,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20,
                color: const Color(0xFF1F4022),
              ),
              Text(
                tilte,
                style: const TextStyle(color: Color(0xFF1F4022)),
              )
            ],
          )),
    );
  }

  Future<ImageSource?> showImageSource(BuildContext context) async {
    if (Platform.isIOS) {
      return showCupertinoModalPopup<ImageSource>(
          context: context,
          builder: (context) => CupertinoActionSheet(
                actions: [
                  CupertinoActionSheetAction(
                      onPressed: () => pickImage(ImageSource.camera),
                      child: const Text(
                        "Camera",
                      )),
                  CupertinoActionSheetAction(
                      onPressed: () => pickImage(ImageSource.gallery),
                      child: const Text(
                        "Gallery",
                      )),
                ],
              ));
    } else {
      return showModalBottomSheet(
        context: context,
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera),
              title: const Text("Camera"),
              onTap: () => pickImage(ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: const Text("Gallery"),
              onTap: () => pickImage(ImageSource.gallery),
            ),
          ],
        ),
      );
    }
  }

  // Future isInteret(BuildContext context) async {
  //   await SyncronizationData.isInternet().then((connection) {
  //     if (connection) {
  //       if (kDebugMode) {
  //         print("Internet connection abailale");
  //       }
  //     } else {
  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(const SnackBar(content: Text("No Internet")));
  //     }
  //   });
  // }

  // Future _getModal(BuildContext context) {
  //   return showModalBottomSheet(
  //     context: context,
  //     builder: (context) => Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: const [
  //         ListTile(
  //           leading: Icon(Icons.camera),
  //           title: Text(
  //               "please click the check button\n for you to save you information"),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<String> famerDetails = [
      widget.farmerName,
      widget.msisdn,
      widget.gender,
      widget.dateOfBirth,
      widget.typofId,
      widget.idNo,
      widget.reigionName,
      widget.districtName,
      widget.communityName
    ];
    return Scaffold(
      appBar: buildAppBar(
        IconButton(
          onPressed: () => {
            Get.back(),
          },
          icon: Icon(
            Icons.arrow_back,
            color: const Color(0xFF1F4022),
            //icon bg color
            size: size.height * 0.03,
          ),
        ),
        size,
        'Take Photo'
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(32),
          child: Column(children: [
            ClipOval(
                child: image != null
                    ? ImageWidget(
                        image: image!,
                        onClicked: (source) => pickImage(source),
                      )
                    : Image.asset(
                        'assets/images/foodwing.PNG',
                        height: size.height * 0.3,
                      )),
            const SizedBox(
              height: 16,
            ),
            _buildButton(
                tilte: "Upload Farmer Photo",
                icon: Icons.camera_alt_outlined,
                onCliked: () => showImageSource(context)),
            // const Text("Farmer Details"),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: size.height * 0.09,
                  width: size.width * 0.4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      // backgroundBlendMode: BlendMode.overlay,
                      color: const Color(0xFF5AA54B),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xFFF407A3E),
                          offset: Offset(2.5, 5.5),
                          blurRadius: 5.0,
                        )
                      ]),
                  child: Center(
                    // padding: EdgeInsets.only(left: size.height* 0.02, top: 10),
                    child: Text(
                      "Name: " + widget.farmerName,
                      style: TextStyle(
                        fontSize: size.height * 0.02,
                        color: Color(0xFF1F4022),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: size.height * 0.09,
                  width: size.width * 0.4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      // backgroundBlendMode: BlendMode.overlay,
                      color: const Color(0xFF5AA54B),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xFFF407A3E),
                          offset: Offset(2.5, 5.5),
                          blurRadius: 5.0,
                        )
                      ]),
                  child: Center(
                    // padding: EdgeInsets.only(left: 15, top: 10),
                    child: Text(
                      "District: " + widget.districtName,
                      style: TextStyle(
                        fontSize: size.height * 0.02,
                        color: Color(0xFF1F4022),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: size.height * 0.09,
                  width: size.width * 0.4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      // backgroundBlendMode: BlendMode.overlay,
                      color: const Color(0xFF5AA54B),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xFFF407A3E),
                          offset: Offset(2.5, 5.5),
                          blurRadius: 5.0,
                        )
                      ]),
                  child: Center(
                    // padding: EdgeInsets.only(left: 15, top: 10),
                    child: Text(
                      "Mobile No: " + widget.msisdn,
                      style: TextStyle(
                        fontSize: size.height * 0.02,
                        color: Color(0xFF1F4022),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: size.height * 0.09,
                  width: size.width * 0.4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      // backgroundBlendMode: BlendMode.overlay,
                      color: const Color(0xFF5AA54B),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xFFF407A3E),
                          offset: Offset(2.5, 5.5),
                          blurRadius: 5.0,
                        )
                      ]),
                  child: Center(
                    // padding: EdgeInsets.only(left: 15, top: 10),
                    child: Text(
                      "Gender :" + widget.gender,
                      style: TextStyle(
                        fontSize: size.height * 0.02,
                        color: Color(0xFF1F4022),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: size.height * 0.09,
                  width: size.width * 0.4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      // backgroundBlendMode: BlendMode.overlay,
                      color: const Color(0xFF5AA54B),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xFFF407A3E),
                          offset: Offset(2.5, 5.5),
                          blurRadius: 5.0,
                        )
                      ]),
                  child: Center(
                    // padding: EdgeInsets.only(left: 15, top: 10),
                    child: Text(
                      "Date of Birth :" + widget.dateOfBirth,
                      style: TextStyle(
                        fontSize: size.height * 0.02,
                        color: Color(0xFF1F4022),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: size.height * 0.09,
                  width: size.width * 0.4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      // backgroundBlendMode: BlendMode.overlay,
                      color: const Color(0xFF5AA54B),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xFFF407A3E),
                          offset: Offset(2.5, 5.5),
                          blurRadius: 5.0,
                        )
                      ]),
                  child: Center(
                    // padding: EdgeInsets.only(left: 15, top: 10),
                    child: Text(
                      "Type of Id : " + widget.typofId,
                      style: TextStyle(
                        fontSize: size.height * 0.02,
                        color: Color(0xFF1F4022),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: size.height * 0.09,
                  width: size.width * 0.4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      // backgroundBlendMode: BlendMode.overlay,
                      color: const Color(0xFF5AA54B),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xFFF407A3E),
                          offset: Offset(2.5, 5.5),
                          blurRadius: 5.0,
                        )
                      ]),
                  child: Center(
                    // padding: EdgeInsets.only(left: 15, top: 10),
                    child: Text(
                      "Id Number:" + widget.idNo,
                      style: TextStyle(
                        fontSize: size.height * 0.02,
                        color: Color(0xFF1F4022),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: size.height * 0.09,
                  width: size.width * 0.4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      // backgroundBlendMode: BlendMode.overlay,
                      color: const Color(0xFF5AA54B),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xFFF407A3E),
                          offset: Offset(2.5, 5.5),
                          blurRadius: 5.0,
                        )
                      ]),
                  child: Center(
                    child: Text(
                      "Region : " + widget.reigionName,
                      style: TextStyle(
                        fontSize: size.height * 0.02,
                        color: Color(0xFF1F4022),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: size.height * 0.09,
                  width: size.width * 0.4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      // backgroundBlendMode: BlendMode.overlay,
                      color: const Color(0xFF5AA54B),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xFFF407A3E),
                          offset: Offset(2.5, 5.5),
                          blurRadius: 5.0,
                        )
                      ]),
                  child: Center(
                    // padding: EdgeInsets.only(left: 15, top: 10),
                    child: Text(
                      "Language: " + widget.lannguage,
                      style: TextStyle(
                        fontSize: size.height * 0.02,
                        color: Color(0xFF1F4022),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: size.height * 0.09,
                  width: size.width * 0.4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      // backgroundBlendMode: BlendMode.overlay,
                      color: const Color(0xFF5AA54B),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xFFF407A3E),
                          offset: Offset(2.5, 5.5),
                          blurRadius: 5.0,
                        )
                      ]),
                  child: Center(
                    // padding: EdgeInsets.only(left: 15, top: 10),
                    child: Text(
                      "Community : " + widget.communityName,
                      style: TextStyle(
                        fontSize: size.height * 0.02,
                        color: const Color(0xFF1F4022),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Checkbox(
                  activeColor: const Color(0xFFF407A3E),
                  value: _checkbox,
                  onChanged: (value) {
                    setState(() {
                      _checkbox = !_checkbox;
                    });
                  },
                ),
                const Text(
                    'By checking the check box,\n You accept  the terms and conditions'),
              ],
            ),
            // CheckboxListTile(
            //   controlAffinity: ListTileControlAffinity.leading,
            //   title: Text('I am true now'),
            //   value: _checkboxListTile,
            //   onChanged: (value) {
            //     setState(() {
            //       _checkboxListTile = !_checkboxListTile;
            //     });
            //   },
            // ),
            _createFarmerButton()
            // Text("Farmer Name :" + widget.farmerName),
            // Text("Phone Number :" + widget.msisdn),
            // Text("Gender :" + widget.gender),
            // Text("Date of Birth :" + widget.dateOfBirth),
            // Text("Type of Id : " + widget.typofId),
            // Text("Id Number:" + widget.idNo),
            // Text("Region : " + widget.reigionName),
            // Text("District : " + widget.districtName),
            // Text("Community : " + widget.communityName),

            // _buildButton(
            //   tilte: "Take a Pickture",
            //   icon: Icons.camera,
            //   onCliked: () => pickImage(ImageSource.camera),
            // ),
          ]),
        ),
      ),
    );
  }

  Widget _createFarmerButton() {
    Size size = MediaQuery.of(this.context).size;
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
          boxShadow: [
            BoxShadow(
              color: _checkbox ? Color(0xFFF5AB2C) : Colors.grey,
              offset: Offset(2.5, 5.5),
              blurRadius: 5.0,
            ),
          ],
          color: _checkbox ? const Color(0xFFC29626) : Colors.grey,
        ),
        child: TextButton(
            onPressed: _checkbox
                ? () {
                    _showDialog(this.context);
                  }
                : null,
            child: _checkbox
                ? const Text(
                    "Save&Sync",
                    style: TextStyle(
                      color: Color(0xFF1F4022),
                    ),
                  )
                : const Text(
                    "Click the checkbox to save&Sync",
                    style: TextStyle(
                      color: Color(0xFF1F4022),
                    ),
                  )),
      ),
    );
  }

  _creatFarmButton() {
    farmerController.creatFarmer(widget.farmerName, widget.msisdn,
        widget.communityName, widget.districtId);

    Get.to(AddFarmFrom(
        communityName: widget.communityName,
        districtName: widget.districtName,
        farmerName: widget.farmerName,
        districtId: widget.districtId));
  }

  _createFarmeButton() {
    farmerController.creatFarmer(widget.farmerName, widget.msisdn,
        widget.communityName, widget.districtId);

    Get.to(ViewFarmers());
  }

  void _showDialog(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Farmer Creation Processing",
            style: TextStyle(
                color: Color(0xFF1F4022),
                fontSize: 15,
                fontFamily: "Roboto",
                fontStyle: FontStyle.normal),
          ),
          content: Container(
              height: size.height * 0.09,
              width: size.width * 0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: const SizedBox(
                child: Text("Would you like to map the farm?"),
              )),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: size.width * 0.3),
              child: TextButton(
                child: const Text("YES"),
                onPressed: () {
                  _creatFarmButton();
                },
              ),
            ),
            TextButton(
              child: const Text("NO"),
              onPressed: () {
                _createFarmeButton();
              },
            ),
          ],
        );
      },
    );
  }

  //saving to the sqlite

}
