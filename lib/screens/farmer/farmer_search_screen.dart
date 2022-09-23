import 'package:FoodWings/screens/home/home_screen.dart';
import 'package:FoodWings/utils/app_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../controllers/farmers/farmer_controller.dart';
import '../farm/view_farm.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> foodList = [
    'Orange',
    'Berries',
    'Lemons',
    'Apples',
    'Mangoes',
    'Dates',
    'Avocados',
    'Black Beans',
    'Chickpeas',
    'Pinto beans',
    'White Beans',
    'Green lentils',
    'Split Peas',
    'Rice',
    'Oats',
    'Quinoa',
    'Pasta',
    'Sparkling water',
    'Coconut water',
    'Herbal tea',
    'Kombucha',
    'Almonds',
    'Peannuts',
    'Chia seeds',
    'Flax seeds',
    'Canned tomatoes',
    'Olive oil',
    'Broccoli',
    'Onions',
    'Garlic',
    'Carots',
    'Leafy greens',
    'Meat',
  ];
  List<String>? foodListSearch;

  // List<ViewFarmerModel>> searchFarmer =
  final FocusNode _textFocusNode = FocusNode();
  TextEditingController? _textEditingController = TextEditingController();
  final FarmerController farmerController = Get.put(FarmerController());

  @override
  void dispose() {
    _textFocusNode.dispose();
    _textEditingController!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
        'Search'
      ),
      body: Center(
        child: Container(
          height: size.height,
          width: size.height,
          decoration: const BoxDecoration(
            color: Color(0xfff8f8f8), //background color
          ),
          child: SafeArea(
              child: Padding(
                  padding: EdgeInsets.only(
                    top: size.height * 0.02,
                  ),
                  child: ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: size.height * 0.04,
                          left: size.width * 0.03,
                          right: size.width * 0.03,
                        ),
                        child: Container(
                          height: size.height * 0.06,
                          width: size.width * 0.3,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: TextField(
                            controller: _textEditingController,
                            focusNode: _textFocusNode,
                            cursorColor: Colors.black,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintText: 'Search here',
                                contentPadding: EdgeInsets.all(10)),
                            onChanged: (value) {
                              setState(() {
                                foodListSearch = foodList
                                    .where((element) =>
                                        element.contains(value.toLowerCase()))
                                    .toList();
                                if (_textEditingController!.text.isNotEmpty &&
                                    foodListSearch!.length == 0) {
                                  print(
                                      'foodListSearch length ${foodListSearch!.length}');
                                }
                              });
                            },
                          ),
                        ),
                      ),
                      Card(
                          child: Container(
                              alignment: Alignment.center,
                              height: 150,
                              width: 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Color.fromARGB(255, 189, 221, 241)),
                              child: Stack(
                                children: [
                                  Positioned(
                                    right: 240,
                                    top: 10,
                                    child: Container(
                                      height: 30,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.blue,
                                      ),
                                      child: const Text("Farmer Name"),
                                    ),
                                  ),
                                  // Text("Region"),
                                  // Text("District"),
                                  // Text("Locality"),
                                  // Text("Creation date"),
                                ],
                              ))),
                      Card(
                        child: Column(
                          children: const [
                            ListTile(
                              leading: FlutterLogo(),
                              title: Text('col'),
                              trailing: Icon(Icons.more_vert),
                            ),
                          ],
                        ),
                      ),
                      const Card(
                        child: ListTile(
                          leading: FlutterLogo(),
                          title: Text('One-line with both widgets'),
                          trailing: Icon(Icons.more_vert),
                        ),
                      ),
                      TextButton(
                          onPressed: () => {
                                print("Get farmer Button pressed"),
                              },
                          child: const Text("Get farmers")),
                      GetBuilder<FarmerController>(
                        init: FarmerController(),
                        builder: (data) {
                          return ListView.builder(
                            itemCount: data.vFModelList.length,
                            itemBuilder: (BuildContext context, int index) {
                              // String districtName =
                              //     data.district.districtName ??
                              //         "No Districr Name";
                              // String area = data.vFModelList[index].area ??
                              //     "No area Name";
                              // String regionName =
                              //     data.regionModelList[index].regionName ??
                              //         "No Region Name";

                              // String farmarea =
                              //     data.farms.area ?? "no farmSize";

                              // regionController.filterRegionDistrict(
                              //     data.vFModelList[index].regionId ??
                              //         "no Name",
                              //     data.vFModelList[index].districtId ??
                              //         "null");

                              return Card(
                                child: InkWell(
                                  onTap: () => {
                                    // farmerController.filterFarms(),
                                    // Get.to(ViewFarm(farmer: data.vFModelList)),

                                    // viewFarmerController.sumFarmerandTheirFarms(),
                                    print(
                                        "object =====================================" +
                                            data.vFModelList[index].id!),
                                  },
                                  child: Container(
                                    height: 300,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white12,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: const Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ]),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          top: 10,
                                          width: size.width * 0.9,
                                          left: 10,
                                          child: Text("Name: " +
                                              data.vFModelList[index]
                                                  .farmerName!),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ))),
        ),
      ),
    );
  }
}
