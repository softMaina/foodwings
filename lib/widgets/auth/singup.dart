import 'package:FoodWings/screens/auth/signup_screen.dart';
import 'package:FoodWings/widgets/auth/singup.dart';
import 'package:flutter/material.dart';

import '../../screens/home/home_screen.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpForm createState() => _SignUpForm();
}

class _SignUpForm extends State<SignUpForm> {
  late String _name;
  late String _phone;
  late String _email;
  late String _password;
  late String _confirmPassword;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 20, left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "ENTER YOUR NAME",
              style: TextStyle(
                color: Color.fromARGB(136, 136, 136, 136),
              ),
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "NDIVOI",
                fillColor: Color(0xEFF9FAFB),
                filled: true,
                labelStyle: TextStyle(fontSize: 12, color: Color(0xFF888888))),
          ),
        ],
      ),
    );
  }

  Widget _buildPhone() {
    MediaQueryData mediaQuery = MediaQuery.of(context);

    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 20, left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              "ENTER YOUR PHONE",
              style: TextStyle(
                color: Color.fromARGB(136, 136, 136, 136),
              ),
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "254708491516",
                fillColor: Color(0xEFF9FAFB),
                filled: true,
                labelStyle: TextStyle(fontSize: 12, color: Color(0xFF888888))),
          ),
        ],
      ),
    );
  }

  Widget _buildEmail() {
    MediaQueryData mediaQuery = MediaQuery.of(context);

    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 20, left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              "ENTER YOUR EMAIL",
              style: TextStyle(
                color: Color.fromARGB(136, 136, 136, 136),
              ),
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "infor@gmail.com",
                fillColor: Color(0xEFF9FAFB),
                filled: true,
                labelStyle: TextStyle(fontSize: 14, color: Color(0xFF888888))),
          ),
        ],
      ),
    );
  }

  Widget _buildPassWord() {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 20, left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              "PASSWORD",
              style: TextStyle(
                color: Color.fromARGB(136, 136, 136, 136),
              ),
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "***************",
                fillColor: Color(0xEFF9FAFB),
                filled: true,
                labelStyle: TextStyle(fontSize: 12, color: Color(0xFF888888))),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmPassword() {
    MediaQueryData mediaQuery = MediaQuery.of(context);

    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 20, left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              "CONFIRM PASSWORD",
              style: TextStyle(
                color: Color.fromARGB(136, 136, 136, 136),
              ),
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "************",
                fillColor: Color(0xEFF9FAFB),
                filled: true,
                labelStyle: TextStyle(fontSize: 12, color: Color(0xFF888888))),
          ),
        ],
      ),
    );
  }

  Widget _forgotPassWordButton() {
    return TextButton(
        onPressed: () => {}, child: const Text("Forgot Password"));
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);

    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.only(top: 80.0),
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              color: Colors.white),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const Padding(
              padding: EdgeInsets.only(top: 30.0, right: 180.0),
              child: Text(
                "Register",
                style: TextStyle(
                  color: Color(0xFF1F4022),
                  fontFamily: "Roboto",
                  fontSize: 24,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 5, right: 180.0),
              child: Text(
                "Create your account",
                style: TextStyle(
                  color: Color.fromARGB(136, 136, 136, 136),
                ),
              ),
            ),
            _buildName(),
            _buildPhone(),
            _buildEmail(),
            _buildPassWord(),
            _buildConfirmPassword(),
            Padding(
              padding: const EdgeInsets.only(
                top: 5,
              ),
              child: TextButton(
                onPressed: () => {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SingUpScrenn(),
                    ),
                  )
                },
                child: const Text(
                  "I have an Account",
                  style: TextStyle(
                      color: Color(0xFF1F4022),
                      fontFamily: "Roboto",
                      fontSize: 16),
                ),
              ),
            ),
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
                                builder: (context) => const HomeScreen()))
                      },
                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 16, color: Color(0xFFFFFFFF)),
                  )),
            )
          ]),
        ),
      ),
    );
  }
}
