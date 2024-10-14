import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeScreen(),
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1; // Default to the RecordScreen tab

  static const List<Widget> _pages = <Widget>[
    CheckInScreen(),   // CheckIn Screen
    RecordScreen(),    // Record Screen
    MapScreen(),       // Map Screen
    ProfileScreen(),   // Profile Screen
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance App'),
      ),
      body: _pages[_selectedIndex],  // Display the selected screen
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.check), label: 'CheckIN'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Record'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped, // Update the selected index when tapped
      ),
    );
  }
}

class CheckInScreen extends StatelessWidget {
  const CheckInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CheckIN')),
      body: const Center(child: Text('CheckIN Screen')),
    );
  }
}

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Map')),
      body: const Center(child: Text('Map Screen')),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: const Center(child: Text('Profile Screen')),
    );
  }
}

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RecordScreenState createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  List<Map<String, String>> records = [
    {"date": "27 Sep", "hours": "7hrs:44ms"},
    {"date": "28 Sep", "hours": "7hrs:44ms"},
    {"date": "30 Sep", "hours": "7hrs:44ms"},
    {"date": "01 Oct", "hours": "7hrs:44ms"},
    {"date": "02 Oct", "hours": "7hrs:44ms"},
    {"date": "03 Oct", "hours": "7hrs:44ms"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Record'),
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false, // Disable the "Chennai" back button or location
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'This Month',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: records.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Circle for Date
                      Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.lightGreen,
                            child: Text(
                              records[index]['date']!.split(' ')[0],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          if (index != records.length - 1)
                            Container(
                              height: 40,
                              width: 2,
                              color: Colors.black26,
                            ),
                        ],
                      ),
                      const SizedBox(width: 16), // Space between circle and text
                      // Date and Time Information in Rounded Box
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "${records[index]['date']}, Working Hrs : ${records[index]['hours']}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
