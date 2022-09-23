import 'package:FoodWings/screens/mapping/map_farm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/farm/crop_controller.dart';
import '../../controllers/farmers/farmer_controller.dart';
import '../../models/farm/crop_model.dart';
import '../../models/farmers/view_farmer.dart';
import '../../utils/app_bar.dart';

class AddFarmFrom extends StatefulWidget {
  final String farmerName;
  final String districtName;
  final String communityName;

  final String districtId;
  const AddFarmFrom(
      {Key? key,
      required this.farmerName,
      required this.districtName,
      required this.communityName,
      required this.districtId})
      : super(key: key);

  @override
  State<AddFarmFrom> createState() => _AddFarmFromState();
}

class _AddFarmFromState extends State<AddFarmFrom> {
  TextEditingController _farmerNameController = TextEditingController();
  TextEditingController _communityNameController = TextEditingController();
  TextEditingController _districtNameController = TextEditingController();
  TextEditingController _plantingDateController = TextEditingController();
  TextEditingController _ploughingDateController = TextEditingController();
  // FarmerController farmerController = Get.put(FarmerController());

  late String _districtName;
  String? _farmeName;
  late String _communityName;

  String? _farmerId;
  late String _districtId;
  late String _cropId;

  ViewFarmerModel? _farmer2;
  Datum? _cropType;

  DateTime _plantingDate = DateTime(2022, 12, 31, 7, 30);
  DateTime _ploughingDate = DateTime(2022, 12, 31, 7, 30);

  @override
  void initState() {
    super.initState();
    _farmerNameController.text = widget.farmerName;
    _communityNameController.text = widget.communityName;
    _districtNameController.text = widget.districtName;
    _districtId = widget.districtId;
  }

  Widget _nameBuild() {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.fromLTRB(size.width * 0.05, size.height * 0.03,
          size.width * 0.05, size.height * 0.01),
      child: GetBuilder<FarmerController>(
          init: FarmerController(),
          builder: (_) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Text(
                    "Farmer  Name",
                    style: TextStyle(
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
                    child: DropdownButton<ViewFarmerModel>(
                        value: _farmer2,
                        hint: const Padding(
                          padding: EdgeInsets.fromLTRB(22.0, 0, 0, 0),
                          child: Text(
                            "Select Farmer Name....",
                            style: TextStyle(),
                          ),
                        ),
                        items: _.vFModelList
                            .map<DropdownMenuItem<ViewFarmerModel>>(
                                (ViewFarmerModel value) {
                          return DropdownMenuItem<ViewFarmerModel>(
                            value: value,
                            child: Text(value.farmerName!),
                          );
                        }).toList(),
                        onChanged: (value) {
                          _farmer2 = value;
                          // print("Print" + value!.id!);
                          var farmer_id = value!.id;
                          setState(() {
                            _farmerId = farmer_id;
                            // _farmeName = value.farmerName;
                          });
                        }),
                  ),
                ),
              ],
            );
          }),
    );
  }

  Widget _cropBuild() {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.fromLTRB(size.width * 0.05, size.height * 0.03,
          size.width * 0.05, size.height * 0.01),
      child: GetBuilder<CropController>(
          init: CropController(),
          builder: (_) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Text(
                    "Crop Type",
                    style: TextStyle(
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
                    child: DropdownButton<Datum>(
                        value: _cropType,
                        hint: const Padding(
                          padding: EdgeInsets.fromLTRB(22.0, 0, 0, 0),
                          child: Text(
                            "Select Crop Name....",
                            style: TextStyle(),
                          ),
                        ),
                        items: _.croptypes
                            .map<DropdownMenuItem<Datum>>((Datum value) {
                          return DropdownMenuItem<Datum>(
                            value: value,
                            child: Text(value.fullname!),
                          );
                        }).toList(),
                        onChanged: (value) {
                          print("Crop Name" + value!.fullname!);
                          setState(() {
                            _cropId = value.id!;
                            _cropType = value;
                          });
                        }),
                  ),
                ),
              ],
            );
          }),
    );
  }

  Widget _communityBuild() {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.fromLTRB(size.width * 0.05, size.height * 0.03,
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
              controller: _communityNameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  hintText: "Accra community.....",

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

  Widget _plantingDateBuild() {
    final hours = _plantingDate.hour.toString().padLeft(2, '0');
    final minutes = _plantingDate.minute.toString().padLeft(2, '0');
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.fromLTRB(size.width * 0.05, size.height * 0.01,
          size.width * 0.05, size.height * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "Planting Date",
              style: TextStyle(
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
              controller: _plantingDateController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),

                hintText:
                    "${_plantingDate.year}/${_plantingDate.month}/${_plantingDate.day} ${hours}:${minutes}",

                // fillColor: Color(0xEFF9FAFB),
                filled: true,
                labelStyle: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF888888),
                ),
              ),
              readOnly: true,
              onTap: () async {
                pickplantingDateTime();

                String formattedDate =
                    DateFormat('yyyy-MM-dd-hh-mm').format(_plantingDate);
                print(formattedDate);
                setState(() {
                  _plantingDateController.text = formattedDate;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _ploughingDateBuild() {
    final hours = _ploughingDate.hour.toString().padLeft(2, '0');
    final minutes = _ploughingDate.minute.toString().padLeft(2, '0');
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.fromLTRB(size.width * 0.05, size.height * 0.01,
          size.width * 0.05, size.height * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "Ploughing Date",
              style: TextStyle(
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
              controller: _ploughingDateController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),

                hintText:
                    "${_ploughingDate.year}/${_ploughingDate.month}/${_ploughingDate.day} $hours:$minutes",

                // fillColor: Color(0xEFF9FAFB),
                filled: true,
                labelStyle: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF888888),
                ),
              ),
              readOnly: true,
              onTap: () async {
                _ploughingDateTime();
                String formattedDate =
                    DateFormat('yyyy-MM-dd-hh-mm').format(_ploughingDate);
                print("This is Ploughing Date" + formattedDate);
                setState(() {
                  _ploughingDateController.text = formattedDate;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _districtBuild() {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.fromLTRB(size.width * 0.05, size.height * 0.03,
          size.width * 0.05, size.height * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 8),
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
              controller: _districtNameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),

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

  Widget _mappPlot() {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding:
          EdgeInsets.only(top: size.height * 0.05, left: size.width * 0.05),
      child: Container(
        height: 50,
        width: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            boxShadow: const [
              BoxShadow(
                color: Colors.black45,
                offset: Offset(2.5, 5.5),
                blurRadius: 5.0,
              ),
            ],
            color: const Color(0xFF62B34D)),
        child: TextButton(
          onPressed: () => {
            _communityName = widget.communityName,
            if (_farmerId!.isEmpty ||
                _districtId.isEmpty ||
                _communityName.isEmpty)
              {print("No farm object")}
            else
              {
                Get.to(MapFarm(
                  farmerId: _farmerId!,
                  districtId: _districtId,
                  cropId: _cropId,
                  plantingDate: _plantingDate,
                  ploughingDate: _ploughingDate,
                  area: _communityName,
                )),
              }
          },
          child: const Text(
            "Map Your Farm",
            style: TextStyle(
              color: Color(0xFF1F4022),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // farmerController.viewFarmers();

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
        ''
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(
                    size.width * 0.2,
                    size.height * 0.05,
                    size.width * 0.15,
                    size.height * 0.05,
                  ),
                  child: const Text(
                    'Your Farm Details',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Color(0xFF1F4022),
                    ),
                  ),
                ),
                _nameBuild(),
                _cropBuild(),
                _districtBuild(),
                _communityBuild(),
                _plantingDateBuild(),
                _ploughingDateBuild(),
                _mappPlot()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future pickplantingDateTime() async {
    DateTime? date = await pickplantingDate();
    if (date == null) return;
    TimeOfDay? time = await pickplantingTime();
    if (time == null) return;
    final dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    setState(() {
      this._plantingDate = dateTime;
    });
  }

  Future<DateTime?> pickplantingDate() => showDatePicker(
        context: context,
        initialDate: _plantingDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
      );

  Future<TimeOfDay?> pickplantingTime() => showTimePicker(
      context: context,
      initialTime:
          TimeOfDay(hour: _plantingDate.hour, minute: _plantingDate.minute));

  Future _ploughingDateTime() async {
    DateTime? date = await pickploughingDate();
    if (date == null) return;
    TimeOfDay? time = await pickploughingDateTime();
    if (time == null) return;
    final dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    setState(() {
      this._ploughingDate = dateTime;
    });
  }

  Future<DateTime?> pickploughingDate() => showDatePicker(
        context: context,
        initialDate: _ploughingDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
      );

  Future<TimeOfDay?> pickploughingDateTime() => showTimePicker(
      context: context,
      initialTime:
          TimeOfDay(hour: _ploughingDate.hour, minute: _ploughingDate.minute));
}
