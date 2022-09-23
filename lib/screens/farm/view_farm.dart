import 'package:FoodWings/screens/home/home_screen.dart';
import 'package:FoodWings/screens/mapping/map_farm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/farmers/farmer_controller.dart';
import '../../models/farmers/view_farmer.dart';
import '../../utils/app_bar.dart';

class ViewFarm extends StatefulWidget {
  final ViewFarmerModel farmer;

  const ViewFarm({Key? key, required this.farmer}) : super(key: key);

  @override
  _ViewFarmState createState() => _ViewFarmState();
}

class _ViewFarmState extends State<ViewFarm> {
  final FarmerController farmerController = Get.put(FarmerController());
  late Size size;
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    Text(
      'Index 1: Search',
      style: optionStyle,
    ),
    Text(
      'Index 2: Settings',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    farmerController.viewFarmers();
    print("Famer Name from view farms: ${widget.farmer.farms!.length}");
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(
          TextButton(
            onPressed: () => {Get.back()},
            child: Icon(
              Icons.arrow_left,
              color: const Color(0XFF009783), //icon bg color
              size: size.height * 0.04,
            ),
          ),
          size,
          'Farm'),
      backgroundColor: const Color(0xEFF9FAFB),
      body: SafeArea(
        child: _bodyWidget(context),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Color(0xFF1F4022),
            icon: Icon(
              Icons.home,
              color: Color(0xFF1F4022),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: Color(0xFF1F4022),
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xFF1F4022),
            icon: Icon(
              Icons.settings,
              color: Color(0xFF1F4022),
            ),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF1F4022),
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _bodyWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: widget.farmer.farms!.length,
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: size.height * 0.2,
              width: size.width * 0.8,
              child: Card(
                elevation: 1,
                clipBehavior: Clip.antiAlias,
                shadowColor: Colors.white70,
                child: Stack(children: [
                  Positioned(
                    top: 10,
                    width: size.width * 0.9,
                    left: 10,
                    child: Text(
                        "Locality: ${widget.farmer.farms![index] ?? "null"} ",
                        style:
                            const TextStyle(color: Colors.amber, fontSize: 25)),
                  ),
                  Positioned(
                    top: 50,
                    width: size.width * 0.9,
                    left: 10,
                    child: Text(
                        "FarmSize: ${widget.farmer.farms![index].farmSize ?? " null"} "),
                  ),
                  Positioned(
                    top: 70,
                    width: size.width * 0.9,
                    left: 10,
                    child: Text(
                      "Region :  ${widget.farmer.farms![index].regionId ?? " null"}",
                    ),
                  ),
                  Positioned(
                    top: 90,
                    width: size.width * 0.9,
                    left: 10,
                    child: Text(
                      "District : ${widget.farmer.farms![index].districtId ?? " null"} ",
                    ),
                  ),
                  Positioned(
                      right: 0,
                      bottom: 0,
                      child: TextButton(
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) =>   MapFarm(
                            //       farmerId: farmerId,
                            //       districtId: districtId,
                            //       cropId: cropId,
                            //       area: area,
                            //       plantingDate: plantingDate,
                            //       ploughingDate: ploughingDate)),
                            // );
                          },
                          child: const Text(
                            'Map Farm',
                            style: TextStyle(color: Colors.amber),
                          ))),
                ]),
              ),
            );
          }),
    );
  }
}
