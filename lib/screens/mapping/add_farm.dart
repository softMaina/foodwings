import 'package:FoodWings/controllers/farm/crop_controller.dart';

import 'package:FoodWings/models/farm/crop_model.dart';
import 'package:FoodWings/models/farm/farm.dart' as F;

import 'package:FoodWings/utils/dbhelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../models/regions/District.dart';
import '../../models/regions/Region.dart';
import '../../utils/app_bar.dart';
import '../../utils/constants.dart';
import 'map_farm.dart';

class AddFarmScreen extends StatefulWidget {
  final String farmerName;
  final int? farmerId;

  AddFarmScreen({Key? key, required this.farmerName, required this.farmerId})
      : super(key: key);

  @override
  State<AddFarmScreen> createState() => _AddFarmScreenState();
}

class _AddFarmScreenState extends State<AddFarmScreen> {
  final TextEditingController _areaController = TextEditingController();
  final CropController cropController = Get.put(CropController());
  final TextEditingController _plantingDateController = TextEditingController();
  final TextEditingController _ploughingDateController =
  TextEditingController();
  DateTime _plantingDate = DateTime(2022, 04, 15, 7, 30);
  DateTime _ploughingDate = DateTime(2022, 06, 30, 7, 30);
  DbHelper dbHelper = DbHelper();
   List<String> list = <String>['One', 'Two', 'Three', 'Four'];

  late String _farmerId;
  late String _districtId;
  late String _cropId;
  late String _area;
  late List<Districts> districtOptions;

  Datum? _cropType;
  String? dropdownItem;

  Widget _areaBuild() {
    Size size = MediaQuery
        .of(context)
        .size;
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
              controller: _areaController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  hintText: "Accra community.....",
                  filled: true,
                  labelStyle:
                  const TextStyle(fontSize: 12, color: Color(0xFF888888))),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cropBuild() {
    Size size = MediaQuery
        .of(context)
        .size;
    cropController.viewCrops();
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

  Widget _plantingDateBuild() {
    final hours = _plantingDate.hour.toString().padLeft(2, '0');
    final minutes = _plantingDate.minute.toString().padLeft(2, '0');
    Size size = MediaQuery
        .of(context)
        .size;
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
                "${_plantingDate.year}/${_plantingDate.month}/${_plantingDate
                    .day} $hours:$minutes",

                // fillColor: Color(0xEFF9FAFB),
                filled: true,
                labelStyle: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF888888),
                ),
              ),
              readOnly: true,
              onTap: () async {
                pickPlantingDateTime();

                String formattedDate =
                DateFormat('yyyy-MM-dd-hh-mm').format(_plantingDate);
                print("This is plantingDate: " + formattedDate);
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
    Size size = MediaQuery
        .of(context)
        .size;
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
                "${_ploughingDate.year}/${_ploughingDate.month}/${_ploughingDate
                    .day} $hours:$minutes",

                // fillColor: Color(0xEFF9FAFB),
                filled: true,
                labelStyle: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF888888),
                ),
              ),
              readOnly: true,
              onTap: () async {
                pickPloughingDateTime();

                String formattedDate =
                DateFormat('yyyy-MM-dd-hh-mm').format(_ploughingDate);
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

  Widget _markPlot() {
    Size size = MediaQuery
        .of(context)
        .size;

    return Padding(
      padding: EdgeInsets.only(
          top: size.height * 0.03,
          left: size.width * 0.05,
          bottom: size.height * 0.05),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.amber),
          padding: MaterialStateProperty.all(
              const EdgeInsets.fromLTRB(20, 10, 20, 10)),
          textStyle: MaterialStateProperty.all(
              const TextStyle(fontSize: 30, color: Colors.white)),
        ),
        onPressed: () =>
        {
          _area = _areaController.text,
          if (_farmerId.isEmpty || _districtId.isEmpty || _area.isEmpty)
            {
              Get.snackbar("Error", "Please Ensure You have Filled all fields",
                  snackPosition: SnackPosition.BOTTOM,
                  showProgressIndicator: true,
                  isDismissible: true,
                  backgroundColor: Colors.lightGreen,
                  colorText: Colors.white,
                  duration: 2.seconds)
            }
          else
            {
              // saveDb(),
              Get.to(MapFarm(
                farmerId: _farmerId,
                districtId: _districtId,
                cropId: 2.toString(),
                plantingDate: _plantingDate,
                ploughingDate: _ploughingDate,
                area: _area,
              )),
            }
        },
        child: const Text(
          "Save Farm",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  List<Region> getRegions() {
    List<Region> r = [];
    regions.forEach((x) {
      int id = int.parse(x["region_id"].toString());
      String name = x["region_name"].toString();
      Region i = Region(regionId: id, regionName: name);
      r.add(i);
    });
    return r;
  }

  List<Districts> getDistricts(String regionId) {
    List<Districts> d = [];
    Map<String, Object> region =
        regions
            .where((map) => (map["region_id"] == regionId))
            .toList()
            .first;
    var l = region["districts"] as List;
    l.forEach((x) {
      int id = int.parse(x["district_id"].toString());
      String name = x["district_name"].toString();
      Districts k = Districts(districtId: id, districtName: name);
      d.add(k);
    });
    return d;
  }

  @override
  Widget build(BuildContext context) {
    List<Region> regionOptions = getRegions();
    List crops = cropController.getCrops();
    setState(() {
      _farmerId = widget.farmerId.toString();
    });
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      appBar: buildAppBar(
          IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back,
              color: const Color(0xFF1F4022),
              //icon bg color
              size: size.height * 0.03,
            ),
          ),
          size,
          'Farm Details'),
      body: SafeArea(
        child: ListView(children: [
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Autocomplete<Region>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    return regionOptions
                        .where((Region region) =>
                        region.regionName
                            .toLowerCase()
                            .startsWith(textEditingValue.text.toLowerCase()))
                        .toList();
                  },
                  displayStringForOption: (Region option) => option.regionName,
                  fieldViewBuilder: (BuildContext context,
                      TextEditingController fieldTextEditingController,
                      FocusNode fieldFocusNode,
                      VoidCallback onFieldSubmitted) {
                    return TextField(
                      controller: fieldTextEditingController,
                      focusNode: fieldFocusNode,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    );
                  },
                  optionsViewBuilder: (BuildContext context,
                      AutocompleteOnSelected<Region> onSelected,
                      Iterable<Region> options) {
                    return Align(
                      alignment: Alignment.topLeft,
                      child: Material(
                        child: Container(
                          width: 300,
                          color: Colors.cyan,
                          child: ListView.builder(
                            padding: EdgeInsets.all(10.0),
                            itemCount: options.length,
                            itemBuilder: (BuildContext context, int index) {
                              final Region option = options.elementAt(index);

                              return GestureDetector(
                                onTap: () {
                                  onSelected(option);
                                },
                                child: ListTile(
                                  title: Text(option.regionName,
                                      style:
                                      const TextStyle(color: Colors.white)),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                  onSelected: (Region selection) {
                    districtOptions =
                        getDistricts(selection.regionId.toString());
                    print(districtOptions);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(0.0),
                child: Autocomplete<Districts>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    return districtOptions
                        .where((Districts district) =>
                        district.districtName
                            .toLowerCase()
                            .startsWith(textEditingValue.text.toLowerCase()))
                        .toList();
                  },
                  displayStringForOption: (Districts option) =>
                  option.districtName,
                  fieldViewBuilder: (BuildContext context,
                      TextEditingController fieldTextEditingController,
                      FocusNode fieldFocusNode,
                      VoidCallback onFieldSubmitted) {
                    return TextField(
                      controller: fieldTextEditingController,
                      focusNode: fieldFocusNode,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    );
                  },
                  optionsViewBuilder: (BuildContext context,
                      AutocompleteOnSelected<Districts> onSelected,
                      Iterable<Districts> options) {
                    return Align(
                      alignment: Alignment.topLeft,
                      child: Material(
                        child: Container(
                          width: 300,
                          color: Colors.cyan,
                          child: ListView.builder(
                            padding: EdgeInsets.all(10.0),
                            itemCount: options.length,
                            itemBuilder: (BuildContext context, int index) {
                              final Districts option = options.elementAt(index);

                              return GestureDetector(
                                onTap: () {
                                  onSelected(option);
                                },
                                child: ListTile(
                                  title: Text(option.districtName,
                                      style:
                                      const TextStyle(color: Colors.white)),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                  onSelected: (Districts selection) {
                    _districtId = selection.districtId.toString();
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child:DropdownButton<String>(
                  value: list.first,
                  onChanged: (String? value){
                    print(value);
                  },
                  items: list.map<DropdownMenuItem<String>>((String value){
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value)
                      );
                }).toList(),
              )),
              _plantingDateBuild(),
              _ploughingDateBuild(),
              _areaBuild(),
              _markPlot()
            ],
          )
        ]),
      ),
    );
  }

  saveDb() {
    F.Farm farm = F.Farm(
        int.parse(_farmerId),
        int.parse(_districtId),
        int.parse(_cropId),
        _plantingDate.toString(),
        _ploughingDate.toString(),
        _area,
        '');
    dbHelper.insertFarm(farm);
  }

  Future pickPlantingDateTime() async {
    DateTime? date = await pickPlantingDate();
    if (date == null) return;
    TimeOfDay? time = await pickPlantingTime();
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

  Future<DateTime?> pickPlantingDate() =>
      showDatePicker(
        context: context,
        initialDate: _plantingDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
      );

  Future<TimeOfDay?> pickPlantingTime() =>
      showTimePicker(
          context: context,
          initialTime:
          TimeOfDay(hour: _plantingDate.hour, minute: _plantingDate.minute));

  Future pickPloughingDateTime() async {
    DateTime? date = await pickPloughingDate();
    if (date == null) return;
    TimeOfDay? time = await pickPloughingTime();
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

  Future<DateTime?> pickPloughingDate() =>
      showDatePicker(
        context: context,
        initialDate: _ploughingDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
      );

  Future<TimeOfDay?> pickPloughingTime() =>
      showTimePicker(
          context: context,
          initialTime:
          TimeOfDay(hour: _ploughingDate.hour, minute: _ploughingDate.minute));
}
