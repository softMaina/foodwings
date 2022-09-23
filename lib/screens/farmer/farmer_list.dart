import 'package:FoodWings/utils/dbhelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/farmers/farmer.dart';
import '../mapping/add_farm.dart';

class FarmerList extends StatefulWidget {
  const FarmerList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FarmerListState();
}

class _FarmerListState extends State<FarmerList> {
  DbHelper dbHelper = DbHelper();

  late List<Farmer> farmers;

  Future showData() async {
    await dbHelper.openDb();
    farmers = await dbHelper.getFarmers();
    setState(() {
      farmers = farmers;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    showData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Farmer List',
          style: TextStyle(color: Colors.green),
        ),
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(0),
            child: ListView.builder(
                itemCount: (farmers != null) ? farmers.length : 0,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(farmers[index].name),
                    trailing: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddFarmScreen(
                                    farmerName: farmers[index].name,
                                    farmerId: farmers[index].id,
                                  )),
                        );
                      },
                      child: const Text('Add Farm'),
                    ),
                  );
                })),
      ),
    );
  }
}
