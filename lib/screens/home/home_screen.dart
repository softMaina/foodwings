//
import 'package:FoodWings/controllers/farm/crop_controller.dart';
import 'package:FoodWings/screens/farmer/farmer_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../controllers/farmers/farmer_controller.dart';
import '../farmer/view_farmer_screen.dart';
import 'package:flutter_offline/flutter_offline.dart';

import 'Home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
     const Home(),
    ViewFarmers(),
    const FarmerList(),
    const FarmerList()
  ];
  final FarmerController farmerController = Get.put(FarmerController());
  final CropController cropController = Get.put(CropController());
  final userData = GetStorage();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final snackBar = SnackBar(
    backgroundColor: Colors.amberAccent,
    content: const Text('Synchronizing data ...'),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );
  synchronizeData(){

  }

  @override
  Widget build(BuildContext context) {
    if (farmerController.vFModelList.isEmpty) {
      farmerController.viewFarmers();
    }

    Size size = MediaQuery.of(context).size;
    final double shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool userMobileLayout = shortestSide < 600;
    // final Orientation orientation = MediaQuery.of(context).orientation;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        body: OfflineBuilder(
            connectivityBuilder: (
              BuildContext context,
              ConnectivityResult connectivity,
              Widget child,
            ) {
              final bool connected = connectivity != ConnectivityResult.none;
              if(connected){
                synchronizeData();
              }
              return Stack(fit: StackFit.expand, children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: _widgetOptions.elementAt(_selectedIndex)),
                connected
                    ? Container()
                    : Positioned(
                        bottom: 0,
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          color: Colors.red,
                          height: 30,
                          child: const Center(
                              child: Text(
                            'Offline',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                            ),
                          )),
                        ),
                      ),
              ]);
            },
            child: Container()),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.green,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              backgroundColor: Colors.green,
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
                color: Colors.white,
              ),
              label: 'Farmers',
            ),
            BottomNavigationBarItem(
              backgroundColor: Color(0xFF1F4022),
              icon: Icon(
                Icons.holiday_village_outlined,
                color: Colors.white,
              ),
              label: 'Fields',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(
                Icons.notification_add_outlined,
                color: Colors.white,
              ),
              label: 'Alerts',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
