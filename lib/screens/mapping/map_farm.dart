import 'dart:async';

import 'package:FoodWings/models/farm/farm_model.dart';
import 'package:FoodWings/screens/farmer/view_farmer_screen.dart';
import 'package:FoodWings/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:FoodWings/models/farm/farm.dart' as F;
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../controllers/farm/farm_controller.dart';
import '../../utils/app_bar.dart';
import '../../utils/dbhelper.dart';

class MapFarm extends StatefulWidget {
  final String farmerId;
  final String districtId;
  final String cropId;
  final DateTime plantingDate, ploughingDate;
  final String area;
  const MapFarm({
    Key? key,
    required this.farmerId,
    required this.districtId,
    required this.cropId,
    required this.area,
    required this.plantingDate,
    required this.ploughingDate,
  }) : super(key: key);

  @override
  State<MapFarm> createState() => _MapFarmState();
}

class _MapFarmState extends State<MapFarm> {
  final CreatFarmController _creatFarmController =
      Get.put(CreatFarmController());
  bool isManual = false;
  bool isAuto = false;
  int _counter = 0;
  Duration duration = const Duration();
  Timer? timer;
  int _seconds = 5;
  Position? _currentPosition;
  DbHelper dbHelper = DbHelper();
  var _latitude = "";
  var _longitude = "";
  var _altitude = "";
  var _speed = "";
  var _address = "";
  var _accuracy = "";
  bool _active = false;
  int _polygonIdCounter = 1;
  List<LatLng> polygonsLatLngs = <LatLng>[];
  final List<Coordinate> polygonsLatLngs2 = [];
  final Set<Polygon> _polygons = Set<Polygon>();

  Future<void> _updatePosition() async {
    Position pos = await _determinePosition();
    setState(() {
      _latitude = pos.latitude.toString();
      _longitude = pos.longitude.toString();
      _altitude = pos.altitude.toString();
      _speed = pos.speed.toString();
      _accuracy = pos.accuracy.toString();
      Coordinate latLng = Coordinate(latitude: 0, longitude: 0);
      latLng.latitude = pos.latitude;
      latLng.longitude = pos.longitude;
      polygonsLatLngs2.add(latLng);
    });
  }

  Future<void> _updateAccuracy() async {
    Position pos = await _determinePosition();
    setState(() {
      _latitude = pos.latitude.toString();
      _longitude = pos.longitude.toString();
      _altitude = pos.altitude.toString();
      _speed = pos.speed.toString();
      _accuracy = pos.accuracy.toString();
    });
  }

  Future<Position> _determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Lacation Permision denied");
      }
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  void addTime() {
    const addSeconds = 1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      duration = Duration(seconds: seconds);
    });
  }

  void _startTime() {
    timer = Timer.periodic(Duration(seconds: 5), (_) {
      _updatePosition();
      addTime();
    });
  }

  void _startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      _updateAccuracy();
      addTime();
    });
  }


  void _setPolygon() {
    final String polygonIdVal = 'polygon_$_polygonIdCounter';
    _polygonIdCounter++;

    _polygons.add(
      Polygon(
          polygonId: PolygonId(polygonIdVal),
          points: polygonsLatLngs,
          strokeWidth: 2,
          fillColor: Colors.transparent),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Read and Follow the Instruction Carefully",
            style: TextStyle(
                color: Color(0xFF1F4022),
                fontSize: 15,
                fontFamily: "Roboto",
                fontStyle: FontStyle.normal),
          ),
          content: Container(
            height: 230,
            width: 550,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  "0. Check if you have turned on your Location on you Tablet.",
                ),
                Text("1. Go to the First conner of the Plot."),
                Text(" 2. While there, click to  Start Mapping Button"),
                Text(
                    "3. As You walk around the Farm the app pick up coordinates after ever 5 seconds"),
                Text(
                    "4. After walking around the farm Press Stop Mapping and The Click Save&Sync button."),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text("Click:  Save&Sync"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _incrementCounter() {
    setState(() {
      _updatePosition();
      _counter++;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          content: const Text("Choose prefered type of mapping"),
          actions: [
            Container(
              height: 30,
              width: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
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
                onPressed: () {
                  setState(() {
                    if (isManual) {
                      isManual = false;
                    } else {
                      isAuto = true;
                    }
                  });
                  Navigator.pop(context);
                },
                child: const Text(
                  'Auto',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF1F4022),
                  ),
                ),
              ),
            ),
            Container(
              height: 30,
              width: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
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
                onPressed: () {
                   _startTimer();
                  setState(() {
                    if (isAuto) {
                      isAuto = false;
                    } else {
                      isManual = true;
                    }
                  });
                  Navigator.pop(context);
                },
                child: const Text(
                  'Manual',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF1F4022),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(this.context).size;
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
        'Map Farm'
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(),
                  child: TextButton(
                    onPressed: () async {
                      _showDialog(context);
                      // var place = await LocationService()
                      //     .getPlace(_searchController.text);
                      // _goToPlace(place);
                    },
                    child: Text(
                      "How to Map Your Farm",
                      style: TextStyle(
                        fontSize: size.height * 0.03,
                        color: const Color(0xFF1F4022),
                      ),
                    ),
                  ),
                )

                    // ),
                    ),
              ],
            ),
            Text(
              "Accuracy " + _accuracy,
              style: TextStyle(
                fontSize: size.height * 0.02,
                color: Color(0xFF1F4022),
              ),
            ),

            Text(
              "Altitude " + _altitude,
              style: TextStyle(
                fontSize: size.height * 0.02,
                color: Color(0xFF1F4022),
              ),
            ),
            Text(
              (() {
                if (isAuto) {
                  return "Seconds  ${duration.inSeconds}";
                }

                return "Number of Clicks  $_counter";
              })(),
              style: TextStyle(
                fontSize: size.height * 0.02,
                color: Color(0xFF1F4022),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: size.height * 0.07,
                    width: size.width * 0.4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: isAuto
                                ? const Color(0xFFC29626)
                                : const Color.fromARGB(255, 154, 152, 147),
                            offset: Offset(2.5, 5.5),
                            blurRadius: 5.0,
                          ),
                        ],
                        color: isAuto
                            ? const Color(0xFFC29626)
                            : const Color.fromARGB(255, 154, 152, 147)),
                    child: TextButton(
                      child: Text(
                        "Auto",
                        style: TextStyle(
                          fontSize: size.height * 0.03,
                          color: Color(0xFF1F4022),
                        ),
                      ),
                      onPressed: isAuto
                          ? () {
                              polygonsLatLngs2.clear();
                              _updatePosition();
                              _startTime();
                              // _fetchCoordinates();
                            }
                          : null,
                    ),
                  ),
                  Container(
                    height: size.height * 0.07,
                    width: size.width * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: isManual
                              ? const Color(0xFFC29626)
                              : const Color.fromARGB(255, 154, 152, 147),
                          offset: Offset(2.5, 5.5),
                          blurRadius: 5.0,
                        ),
                      ],
                      color: isManual
                          ? const Color(0xFFC29626)
                          : const Color.fromARGB(255, 154, 152, 147),
                    ),
                    child: TextButton(
                      child: Text(
                        "Manual",
                        style: TextStyle(
                          fontSize: size.height * 0.03,
                          color: Color(0xFF1F4022),
                        ),
                      ),
                      onPressed: isManual
                          ? () {
                              // polygonsLatLngs2.clear();
                              _updatePosition();
                              _incrementCounter();

                              // _fetchCoordinates();
                            }
                          : null,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),

            Expanded(
                child: ListView.builder(
                    itemCount: polygonsLatLngs2.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Text(
                        "Latitude: ${polygonsLatLngs2[index].latitude}\n Longitude:  ${polygonsLatLngs2[index].latitude}",
                        style: TextStyle(
                          fontSize: size.height * 0.03,
                          color: Color(0xFF1F4022),
                        ),
                      );
                    })),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: size.height * 0.07,
                    width: size.width * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: isAuto
                              ? const Color(0xFFC29626)
                              : const Color.fromARGB(255, 154, 152, 147),
                          offset: const Offset(2.5, 5.5),
                          blurRadius: 5.0,
                        ),
                      ],
                      color: isAuto
                          ? const Color(0xFFC29626)
                          : const Color.fromARGB(255, 154, 152, 147),
                    ),
                    child: TextButton(
                      child: Text(
                        "Stop Mapping",
                        style: TextStyle(
                          fontSize: size.height * 0.03,
                          color: Color(0xFF1F4022),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          timer?.cancel();

                          duration = const Duration();

                          print("Stop Timer");
                        });
                      },
                    ),
                  ),
                  Container(
                    height: size.height * 0.07,
                    width: size.width * 0.4,
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
                      child: Text(
                        "Save & Sync",
                        style: TextStyle(
                          fontSize: size.height * 0.03,
                          color: Color(0xFF1F4022),
                        ),
                      ),
                      onPressed: () {
                        print('**************************');
                        print('**************************');
                        print('**************************');
                        F.Farm farm = F.Farm( int.parse(widget.farmerId),
                            int.parse(widget.districtId),
                            int.parse(widget.cropId),
                            widget.plantingDate.toString(),
                            widget.ploughingDate.toString(),
                            widget.area, polygonsLatLngs2.toString()) ;
                        dbHelper.insertFarm(farm);
                        dbHelper.getFarms();
                        _creatFarmController.createFarm(
                            widget.farmerId,
                            widget.districtId,
                            widget.cropId,
                            widget.plantingDate,
                            widget.ploughingDate,
                            widget.area,
                            polygonsLatLngs2);

                        // Get.to(ViewFarmers());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
