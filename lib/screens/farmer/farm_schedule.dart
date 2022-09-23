import 'package:flutter/material.dart';

class FarmSchedule extends StatefulWidget {
  const FarmSchedule({Key? key}) : super(key: key);

  @override
  _FarmScheduleState createState() => _FarmScheduleState();
}

class _FarmScheduleState extends State<FarmSchedule> {
  int _value = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Your Schedule"),
        backgroundColor: const Color(0xFF62B34D),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text("Select Farm"),
            DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                value: _value,
                items: const [
                  DropdownMenuItem(
                    child: Text("Farm1"),
                    value: 1,
                  ),
                  DropdownMenuItem(
                    child: Text(" Farm2"),
                    value: 2,
                  ),
                  DropdownMenuItem(
                    child: Text("Farm 3"),
                    value: 3,
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _value = value!;
                  });
                },
                hint: const Text("Select Farm"),
                elevation: 8,
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down_sharp),
              ),
            ),
            DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                value: _value,
                items: const [
                  DropdownMenuItem(
                    child: Text("Crop 1"),
                    value: 1,
                  ),
                  DropdownMenuItem(
                    child: Text("Crop 2"),
                    value: 2,
                  ),
                  DropdownMenuItem(
                    child: Text("Crop 3"),
                    value: 3,
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _value = value!;
                  });
                },
                hint: const Text("Select Crop"),
                elevation: 8,
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down_sharp),
              ),
            ),
            DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                value: _value,
                items: const [
                  DropdownMenuItem(
                    child: Text("Service one"),
                    value: 1,
                  ),
                  DropdownMenuItem(
                    child: Text("Seevie Two"),
                    value: 2,
                  ),
                  DropdownMenuItem(
                    child: Text("Sevice Three"),
                    value: 3,
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _value = value!;
                  });
                },
                hint: const Text("Select Service"),
                elevation: 8,
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down_sharp),
              ),
            ),
            Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              height: 100,
              child: const Text("Here is the date picker"),
            )
          ],
        ),
      ),
    );
  }
}
