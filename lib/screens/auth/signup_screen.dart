import 'package:FoodWings/widgets/auth/singup.dart';
import 'package:flutter/material.dart';

class SingUpScrenn extends StatefulWidget {
  SingUpScrenn({Key? key}) : super(key: key);

  @override
  _SingUpScrennState createState() => _SingUpScrennState();
}

class _SingUpScrennState extends State<SingUpScrenn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: SignUpForm(),
      decoration: const BoxDecoration(color: Color(0xEFF9FAFB)),
    ));
  }
}
