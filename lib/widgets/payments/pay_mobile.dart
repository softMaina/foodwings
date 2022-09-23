import 'package:flutter/material.dart';

class PayViaMobile extends StatefulWidget {
  PayViaMobile({Key? key}) : super(key: key);

  @override
  State<PayViaMobile> createState() => _PayViaMobileState();
}

class _PayViaMobileState extends State<PayViaMobile> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: TextButton(
      onPressed: () => {_showDialog(context)},
      child: const Text("Pay Via Mobile"),
    ));
  }
}

void _showDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Alert!!"),
        content: const Text("You are awesome!"),
        actions: <Widget>[
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
