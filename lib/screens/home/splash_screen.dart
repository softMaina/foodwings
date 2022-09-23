import 'package:FoodWings/screens/auth/login_screen.dart';
import 'package:FoodWings/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 70.0),
            child: Center(
              child: SizedBox(
                width: 200,
                height: 200,
                child: Image.asset('assets/images/FoodWings_logo.png'),
              ),
            ),
          ),
          const Padding(
              padding: EdgeInsets.only(top: 70.0),
              child: Text(
                "GLOBAL",
                style: TextStyle(fontSize: 36, color: Color(0xFF1F4022)),
              )),
          const Spacer(),
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF62B34D),
            ),
            child: TextButton(
                onPressed: () => {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()))
                    },
                child: const Text(
                  "Sign to Your Account",
                  style: TextStyle(fontSize: 16, color: Color(0xFFFFFFFF)),
                )),
          )
        ],
      ),
    );
  }
}
