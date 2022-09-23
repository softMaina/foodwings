import 'package:flutter/material.dart';

import '../home/home_screen.dart';

class MapCreatedScreen extends StatefulWidget {
  const MapCreatedScreen({Key? key}) : super(key: key);

  @override
  _MapCreatedScreenState createState() => _MapCreatedScreenState();
}

class _MapCreatedScreenState extends State<MapCreatedScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    Text(
      'Index 1: Search',
      style: optionStyle,
    ),
    Text(
      'Index 2: Settings',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50, right: 240),
              child: SizedBox(
                height: 30,
                child: IconButton(
                  onPressed: () => {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const RegisterFarm()))
                  },
                  icon: const Icon(Icons.arrow_back_ios_new,
                      color: Color(0xFF1F4022)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                padding: EdgeInsets.all(8),
                child: Image.asset("assets/images/map2.png"),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Color(0xFF1F4022),
            icon: Icon(
              Icons.home,
              color: Color(0xFF1F4022),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: Color(0xFF1F4022),
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xFF1F4022),
            icon: Icon(
              Icons.settings,
              color: Color(0xFF1F4022),
            ),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF1F4022),
        onTap: _onItemTapped,
      ),
    );
  }
}
