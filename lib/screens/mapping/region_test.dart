import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/regions/read_json_controller.dart';
import '../../models/regions/region_model.dart';

class ReadingJsonData extends StatefulWidget {
  const ReadingJsonData({Key? key}) : super(key: key);

  @override
  State<ReadingJsonData> createState() => _ReadingJsonDataState();
}

class _ReadingJsonDataState extends State<ReadingJsonData> {
  RegionDataController readingJsonData = Get.put(RegionDataController());

  String? _selectedRegionId;
  String? _selectedDistrictId;
  RegionsModel? _region;
  Widget _regionBuild() {
    Size size = MediaQuery.of(context).size;
    return Padding(
        padding: EdgeInsets.fromLTRB(size.width * 0.05, size.height * 0.03,
            size.width * 0.05, size.height * 0.01),
        child: FutureBuilder(
          future: readingJsonData.readJsonData(),
          builder: (context, data) {
            if (data.hasError) {
              return Center(child: Text("${data.error}"));
            } else if (data.hasData) {
              var items = data.data as List<RegionsModel>;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Text(
                      "Select Farmer Region Name",
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
                      child: DropdownButton<RegionsModel>(
                          value: _region,
                          hint: const Padding(
                            padding: EdgeInsets.fromLTRB(22.0, 0, 0, 0),
                            child: Text(
                              "Select Region....",
                              style: TextStyle(),
                            ),
                          ),
                          items: readingJsonData.regionModelList
                              .map<DropdownMenuItem<RegionsModel>>(
                                  (RegionsModel value) {
                            return DropdownMenuItem<RegionsModel>(
                              value: value,
                              child: Text(value.regionName!),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedDistrictId = value!.regionId;
                              _region = value;
                              readingJsonData
                                  .filterDistrict(_selectedDistrictId!);
                            });
                          }),
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    //  if (readingJsonData.regionModelList.isEmpty) {
    //   readingJsonData.readJsonData();
    // }
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: ListView(children: [
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(
                    size.width * 0.2,
                    size.height * 0.02,
                    size.width * 0.15,
                    size.height * 0.05,
                  ),
                  child: const Text(
                    'Farm Details',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Color(0xFF1F4022),
                    ),
                  ),
                ),

                _regionBuild(),
                // _districtBuild(),
                // _areaBuild(),
                // _markPlot()
              ],
            ),
          )
        ]),
      ),
    );
  }
}
