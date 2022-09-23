import 'package:FoodWings/screens/farmer/add_famer.dart';
import 'package:FoodWings/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../controllers/auth/login_controller.dart';
import '../../controllers/farmers/farmer_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static GetStorage store = GetStorage();
  bool isLoggedIn = false;
  final LoginController loginController = Get.put(LoginController());
  final FarmerController viewFarmerController = Get.put(FarmerController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final _password = TextEditingController();
  final _username = TextEditingController();

  Future<Position> _determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location Permission denied");
      }
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  @override
  void initState() {
    super.initState();
    checkIfLoggedIn();
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
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
                    " Food-wings collects location data to enable Mapping Features, Calculating of the land in Hectare only  when the app is in use")
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text("Accept"),
              onPressed: () {
                setState(() {
                  _determinePosition();
                });

                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void checkIfLoggedIn() async {
    var token = await store.read("auth");
    if (token == null) {
      isLoggedIn = false;

      Get.to(const LoginPage());
      _showDialog(context);
    } else {
      isLoggedIn = true;
      Get.to(const HomeScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.only(top: size.height * 0.1),
      child: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              color: Colors.white),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Padding(
              padding: EdgeInsets.only(
                  top: size.height * 0.05, right: size.width * 0.04),
              child: Text(
                "Login",
                style: TextStyle(
                  color: Color(0xFF1F4022),
                  fontFamily: "Roboto",
                  fontSize: size.height * 0.05,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: size.height * 0.05, right: size.width * 0.04),
              child: Text(
                "Phone Number as Username",
                style: TextStyle(
                  color: Color.fromARGB(136, 136, 136, 136),
                  fontSize: size.height * 0.03,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: size.height * 0.03, right: size.width * 0.7),
              child: Text(
                "Username",
                style: TextStyle(
                  color: Color.fromARGB(136, 136, 136, 136),
                  fontSize: size.height * 0.03,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: size.height * 0.03,
                  left: size.width * 0.05,
                  right: size.width * 0.03),
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: _username,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: "254..xxx..xxx.xxx or 233..xxx..xxx.xxx",
                  labelStyle: TextStyle(
                      fontSize: size.height * 0.03, color: Color(0xFF888888)),
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Mobile Number is required.';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: size.height * 0.05, right: size.width * 0.7),
              child: Text(
                "Password",
                style: TextStyle(
                  color: Color.fromARGB(136, 136, 136, 136),
                  fontSize: size.height * 0.03,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: size.height * 0.03,
                  left: size.width * 0.05,
                  right: size.width * 0.03),
              child: TextFormField(
                key: _key,
                obscureText: true,
                keyboardType: TextInputType.text,
                controller: _password,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null) {
                    return 'Password is required.';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: size.height * 0.03,
                right: size.width * 0.5,
              ),
              child: const Text(
                "Sign to your Account",
                style: TextStyle(
                  color: Color.fromARGB(136, 136, 136, 136),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  right: size.width * 0.5, top: size.height * 0.04),
              child: TextButton(
                onPressed: () => {},
                child: const Text(
                  "Forgot Password?",
                  style: TextStyle(
                      color: Color(0xFF1F4022),
                      fontFamily: "Roboto",
                      fontSize: 16),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: ElevatedButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.all(20.0)),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.amber)),
                  onPressed: (){_onLoginButtonPressed();},
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: size.height * 0.03,
                      color: Colors.white,
                    ),
                  )),
            ),
          ]),
        ),
      ),
    ));
  }

  _onLoginButtonPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
    if (_username.text != "" && _password.text != "") {
      loginController.login(
        _username.text,
        _password.text,
      );
    } else {
      Get.snackbar("Error", "Please Enter Username or password",
          snackPosition: SnackPosition.BOTTOM,
          showProgressIndicator: true,
          isDismissible: true,
          backgroundColor: Colors.lightGreen,
          colorText: Colors.white,
          duration: 5.seconds);
    }
  }
}
