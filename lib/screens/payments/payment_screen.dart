import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Center(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 60),
                child: SizedBox(
                  height: 50,
                  width: 400,
                  child: Text(
                    "Please Select Payment Mentod",
                    style: TextStyle(
                        color: Color(0xFF1F4022),
                        fontSize: 17,
                        fontFamily: "Roboto",
                        fontStyle: FontStyle.normal),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFF62B34D)),
                  child: TextButton(
                    onPressed: () => {},
                    child: const Text(
                      "Mobile",
                      style: TextStyle(
                          color: Color(0xFF1F4022),
                          fontSize: 20,
                          fontFamily: "Roboto",
                          fontStyle: FontStyle.normal),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFF62B34D)),
                  child: TextButton(
                    onPressed: () => {},
                    child: const Text(
                      "Use Card",
                      style: TextStyle(
                          color: Color(0xFF1F4022),
                          fontSize: 20,
                          fontFamily: "Roboto",
                          fontStyle: FontStyle.normal),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
