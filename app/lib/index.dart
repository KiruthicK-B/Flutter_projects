// ignore_for_file: prefer_const_constructors, sort_child_properties_last, use_build_context_synchronously
//import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'main.dart';
import 'package:flutter/material.dart';
import 'loading_screen.dart';
import 'final_screen.dart';
//import 'package:intl/intl.dart';

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
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  bool _isChatbotOpen = false;
  final TextEditingController _chatController = TextEditingController();
  final List<Map<String, String>> _chatHistory = [];
  String currentLocation = "Chennai, India";
  String currentTemperature = "28°C";
  String userName = "Kiruthick B";
  String userEmail = "kiruthick@gmail.com";
  List<String> tasks = ["Complete project report", "Team meeting at 2 PM"];
  int pendingTasks = 2;

  // List of all the pages
  final List<Widget> _pages = [
    const HomeContent(
        userName: 'Kiruthick B',
        userEmail: 'kiruthick@gmail.com'), // Home content
    const RecordScreen(), // Record screen
    const Placeholder(), // Placeholder for Map screen
    const ProfileScreen(), // Profile screen
    const ProfileEditScreen(), // Profile edit screen
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _toggleChatbot() {
    setState(() {
      _isChatbotOpen = !_isChatbotOpen;
    });
  }

  void _sendMessage() {
    if (_chatController.text.isNotEmpty) {
      String question = _chatController.text;
      String answer = _getChatbotResponse(question);
      setState(() {
        _chatHistory.add({
          'question': question,
          'answer': answer,
        });
        _chatController.clear();
      });
    }
  }

  String _getChatbotResponse(String question) {
    try {
      question = question
          .toLowerCase(); // Convert question to lowercase for easier matching

      if (question.contains("date")) {
        return DateFormat.yMMMMd()
            .format(DateTime.now()); // Returns current date
      } else if (question.contains("time")) {
        return DateFormat.jm().format(DateTime.now()); // Returns current time
      } else if (question.contains("location")) {
        return currentLocation; // Returns current location
      } else if (question.contains("temperature")) {
        return currentTemperature; // Returns current temperature
      } else if (question.contains("schedule")) {
        return tasks.isEmpty
            ? "You have no tasks today!"
            : "Tasks for today: ${tasks.join(', ')}";
      } else if (question.contains("pending tasks")) {
        return pendingTasks == 0
            ? "No pending tasks."
            : "You have $pendingTasks pending tasks.";
      } else if (question.contains("check in")) {
        return "Yes, you can check in now!";
      } else if (question.contains("who am i")) {
        return "You are logged in as $userName.";
      } else if (question.contains("email")) {
        return "Your email is $userEmail.";
      } else if (question.contains("tasks left")) {
        return pendingTasks == 0
            ? "No tasks left."
            : "You have $pendingTasks tasks left.";
      } else {
        return "Sorry, I didn’t understand that. Please ask something else.";
      }
    } catch (e) {
      return "An error occurred while processing your request. Please try again.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF6AB547),
        elevation: 0,
        toolbarHeight: 120,
        flexibleSpace: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Current location and date/time details
                  Row(
                    children: const [
                      Icon(Icons.location_on, color: Colors.white),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Chennai, India",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Thu, 11 Oct 2024 - 10:30 AM", // Add dynamic date and time if needed
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Weather and notification icon
                  Row(
                    children: [
                      Column(
                        children: const [
                          Icon(Icons.wb_sunny,
                              color: Colors.yellow, size: 24), // Weather icon
                          Text(
                            "28°C",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.notifications,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          _pages[_currentIndex],
          if (_isChatbotOpen)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: _chatHistory.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_chatHistory[index]['question']!),
                          subtitle: Text(_chatHistory[index]['answer']!),
                        );
                      },
                    ),
                    Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _chatController,
                                decoration: const InputDecoration(
                                  hintText: 'Ask a question...',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Add a new row for the button and center it
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: _sendMessage,
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white, backgroundColor: const Color(0xFF6AB547), // Text color
                                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0), // Adjust padding as needed
                              ),
                              child: const Text('Send'),
                            ),
                          ],
                        ),

                  ],
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
         onPressed: _toggleChatbot,
         child: const Icon(Icons.smart_toy),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFF6AB547),
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Record',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

extension on Function(String s) {
  yMMMMd() {}

  jm() {}
}

// Home content for the first tab
class HomeContent extends StatelessWidget {
  final String userName;
  final String userEmail;

  const HomeContent(
      {super.key, required this.userName, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, $userName!',
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              userEmail,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),

            // Profile image
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(
                    'assets/profile_image.png'), // Add user profile image
                backgroundColor: Colors.grey.shade300,
              ),
            ),
            const SizedBox(height: 20),

            // Task prompt
            const Text(
              "Today’s Tasks",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),

            // List of tasks or check-ins
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFEFEFEF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "You have no pending tasks. Great job staying up-to-date!",
                style: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(height: 20),

            // Check-in button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle check-in process
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LoadingScreen(),
                    ),
                  );

                  Future.delayed(const Duration(seconds: 3), () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const FinalScreen(),
                      ),
                    );
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6AB547),
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 50.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Check In',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.arrow_forward, size: 24, color: Colors.white),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Motivational quote
            const Center(
              child:
                  Icon(Icons.location_pin, size: 50, color: Color(0xFF6AB547)),
            ),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                "Great things are done by taking small steps every day. Let’s make today count!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Define the RecordScreen as a widget
class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  _RecordScreenState createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  List<Map<String, dynamic>> allRecords = [
    {
      "date": "27 Sep",
      "hours": "7hrs:44m",
      "checkIn": "09:00 AM",
      "checkOut": "05:00 PM",
      "breakTime": "1hr",
      "nonWorkingHours": "15m"
    },
    {
      "date": "28 Sep",
      "hours": "7hrs:50m",
      "checkIn": "09:05 AM",
      "checkOut": "05:10 PM",
      "breakTime": "1hr",
      "nonWorkingHours": "10m"
    },
    {
      "date": "29 Sep",
      "hours": "7hrs:30m",
      "checkIn": "08:50 AM",
      "checkOut": "04:50 PM",
      "breakTime": "1hr",
      "nonWorkingHours": "20m"
    },
    {
      "date": "30 Sep",
      "hours": "7hrs:44m",
      "checkIn": "09:15 AM",
      "checkOut": "05:00 PM",
      "breakTime": "45m",
      "nonWorkingHours": "20m"
    },
    {
      "date": "01 Oct",
      "hours": "7hrs:55m",
      "checkIn": "09:00 AM",
      "checkOut": "05:10 PM",
      "breakTime": "1hr",
      "nonWorkingHours": "5m"
    },
    {
      "date": "02 Oct",
      "hours": "7hrs:40m",
      "checkIn": "09:10 AM",
      "checkOut": "05:00 PM",
      "breakTime": "1hr",
      "nonWorkingHours": "20m"
    },
    {
      "date": "03 Oct",
      "hours": "6hrs:50m",
      "checkIn": "10:00 AM",
      "checkOut": "05:00 PM",
      "breakTime": "1hr",
      "nonWorkingHours": "10m"
    },
    {
      "date": "04 Oct",
      "hours": "7hrs:30m",
      "checkIn": "09:00 AM",
      "checkOut": "04:30 PM",
      "breakTime": "1hr",
      "nonWorkingHours": "20m"
    },
    {
      "date": "05 Oct",
      "hours": "8hrs:15m",
      "checkIn": "08:30 AM",
      "checkOut": "05:00 PM",
      "breakTime": "45m",
      "nonWorkingHours": "15m"
    },
  ];

  List<Map<String, dynamic>> filteredRecords = [];
  Map<int, bool> expandedCards = {};
  DateTime? _selectedDate;
  bool _isFetched = false;

  @override
  void initState() {
    super.initState();
    filteredRecords = allRecords; // Initially display all records
    for (int i = 0; i < filteredRecords.length; i++) {
      expandedCards[i] = false; // Initialize all cards as collapsed
    }
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _isFetched = false; // Reset fetch status after date selection
      });
    }
  }

  void _fetchRecords() {
  if (_selectedDate != null) {
    // Format the selected date only if it's not null
    String formattedDate = DateFormat('dd MMM').format(_selectedDate!);

    setState(() {
      filteredRecords = allRecords
          .where((record) => record['date'] == formattedDate)
          .toList();
      _isFetched = true;

      // Reset expanded states
      expandedCards.clear();
      for (int i = 0; i < filteredRecords.length; i++) {
        expandedCards[i] = false;
      }
    });
  } else {
    // Handle the case where no date is selected
    setState(() {
      filteredRecords = [];
      _isFetched = true;
    });
    // Optionally, show a message to the user asking to select a date
  }
}


  String get selectedDateString {
    if (_selectedDate != null) {
      return DateFormat('dd MMM yyyy').format(_selectedDate!);
    } else {
      return '';
    }
  }

  void _toggleCardExpansion(int index) {
    setState(() {
      expandedCards[index] = !(expandedCards[index] ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Record'),
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          // Date Selection and Fetch Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.calendar_today, color: Colors.green),
                  onPressed: () => _selectDate(context),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    _selectedDate != null
                        ? 'Selected Date: $selectedDateString'
                        : 'Select a date to fetch records',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                ElevatedButton(
                  onPressed: _fetchRecords,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 24.0),
                  ),
                  child: const Text('Fetch',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),

          // Display fetched date
          if (_isFetched && _selectedDate != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Showing records for: $selectedDateString',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ),

          // No records found message
          if (_isFetched && filteredRecords.isEmpty)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'No records found for the selected date.',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            )
          else
            // Records List
            Expanded(
              child: ListView.builder(
                itemCount: filteredRecords.length,
                itemBuilder: (context, index) {
                  final record = filteredRecords[index];
                  final isExpanded = expandedCards[index] ?? false;

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 16.0),
                    child: GestureDetector(
                      onTap: () => _toggleCardExpansion(index),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Card Header
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    record['date'],
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(
                                    isExpanded
                                        ? Icons.expand_less
                                        : Icons.expand_more,
                                    color: Colors.green,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              // Basic Info
                              Text(
                                "Working Hours: ${record['hours']}",
                                style: const TextStyle(fontSize: 16),
                              ),
                              // Expanded Details
                              if (isExpanded) ...[
                                const SizedBox(height: 10),
                                Divider(color: Colors.grey[300]),
                                const SizedBox(height: 10),
                                Text(
                                  "Check-In Time: ${record['checkIn']}",
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "Check-Out Time: ${record['checkOut']}",
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "Break Time: ${record['breakTime']}",
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "Non-Working Hours: ${record['nonWorkingHours']}",
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
floatingActionButton: Column(
  mainAxisSize: MainAxisSize.min,
  mainAxisAlignment: MainAxisAlignment.end, // Align to the bottom of the screen
  children: [
    // Padding to move the FAB above the chatbot button
    Padding(
      padding: const EdgeInsets.only(bottom: 70.0), // Adjust this value to change FAB height
      child: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              int totalWorkingMinutes = 0;
              for (var record in allRecords) {
                String hours = record['hours']!;
                int workingHours = int.parse(hours.split('hrs')[0]);
                int workingMinutes = int.parse(hours.split('hrs:')[1].split('m')[0]);
                totalWorkingMinutes += workingHours * 60 + workingMinutes;
              }
              int totalHours = totalWorkingMinutes ~/ 60;
              int totalMinutes = totalWorkingMinutes % 60;

              return AlertDialog(
                title: const Text('Work Summary'),
                content: Text(
                  'Total Check-In Days: ${allRecords.length}\n'
                  'Total Working Hours: $totalHours hrs $totalMinutes m\n'
                  'Average Break Time: 1hr/day\n'
                  'Average Non-Working Hours: 15m/day',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.info_outline),
      ),
    ),
  ],
),


    );
  }
}

// ignore: non_constant_identifier_names
DateFormat(String s) {}

// Placeholder screens for other tabs
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text(
              'Verifying Location...',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class FinalScreen extends StatefulWidget {
  const FinalScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FinalScreenState createState() => _FinalScreenState();
}

class _FinalScreenState extends State<FinalScreen> {
  int seconds = 0; // Total active time in seconds
  int breakSeconds = 0; // Break time in seconds
  Timer? timer;
  bool isActive = false; // For tracking work session
  bool isBreak = false; // For tracking break session
  bool isCheckedOut = false;
  bool isBreakTimeLimitExceeded = false;

  static const int breakTimeLimit =
      60; // Limit for break time in seconds (e.g. 10 mins)

  // Start timer
  void startTimer() {
    isActive = true;
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        if (isBreak) {
          breakSeconds++;
          if (breakSeconds >= breakTimeLimit) {
            _autoCheckout();
          }
        } else {
          seconds++;
        }
      });
    });
  }

  // Pause the timer (mark it as break)
  void pauseTimer() {
    setState(() {
      isBreak = true;
    });
  }

  // Resume the timer (exit break mode)
  void resumeTimer() {
    setState(() {
      isBreak = false;
    });
  }

  // Stop the timer on checkout
  void stopTimer() {
    timer?.cancel();
    isActive = false;
  }

  // Automatically check out after break limit exceeds
  void _autoCheckout() {
    stopTimer();
    setState(() {
      isBreakTimeLimitExceeded = true;
      isCheckedOut = true;
    });
  }

  // Checkout manually
  void checkOut() {
    stopTimer();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Checking Out..."),
            ],
          ),
        );
      },
    );

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pop(context);
      setState(() {
        isCheckedOut = true;
      });
    });
  }

  // Format time into hours, minutes, seconds
  String formatTime(int totalSeconds) {
    int hours = totalSeconds ~/ 3600;
    int minutes = (totalSeconds % 3600) ~/ 60;
    int secs = totalSeconds % 60;
    return "${hours.toString().padLeft(2, '0')}hrs:${minutes.toString().padLeft(2, '0')}mins:${secs.toString().padLeft(2, '0')}s";
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF6AB547),
        title: const Text("Check In Details"),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/profile.jpeg'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Kiruthick B',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text('Location: Lat: 11.7321, Long: 78.0489'),
            const Text('Region: Salem, Tamil Nadu, India'),
            const SizedBox(height: 10),
            Text('Active Time: ${formatTime(seconds)}'),
            const SizedBox(height: 10),
            Text('Break Time: ${formatTime(breakSeconds)}'),
            const SizedBox(height: 10),
            const Text('Active Status:'),
            Icon(
              isCheckedOut ? Icons.cancel : Icons.check_circle,
              color: isCheckedOut ? Colors.red : Colors.green,
              size: 30,
            ),
            const SizedBox(height: 20),
            if (!isCheckedOut && !isBreakTimeLimitExceeded)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: isBreak ? resumeTimer : pauseTimer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 35.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Text(isBreak ? 'Resume' : 'Pause',
                        style: const TextStyle(fontSize: 18)),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: checkOut,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6AB547),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 35.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child:
                        const Text('Check Out', style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            if (isBreakTimeLimitExceeded)
              const Text(
                "Break Time Limit Exceeded. You've been automatically checked out.",
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            if (isCheckedOut)
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 50.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child:
                    const Text('Back to Home', style: TextStyle(fontSize: 18)),
              ),
            const SizedBox(height: 20),
            const Text(
              "Great things are done by taking small steps every day. Let’s make today count!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

// ProfileScreen Class
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isFAQExpanded = false;
  bool _isSettingsExpanded = false;
  bool _isFullProfile = false;
  final TextEditingController _feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacementNamed('/home'); // Back to homepage
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text("Profile"),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Section with View Full Profile Toggle
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/profile.jpeg'),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.edit, color: Colors.green),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ProfileEditScreen(),
                        ));
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text('Kiruthick B',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const Text('kiruthick@gmail.com'),
              const SizedBox(height: 5),
              const Text('Phone: +91 9342696026'),
              const SizedBox(height: 10),
              if (_isFullProfile) ...[
                const Text('Age: 20'),
                const SizedBox(height: 5),
                const Text('Designation: Software Engineer'),
                const SizedBox(height: 5),
                const Text('Department: IT'),
                const SizedBox(height: 5),
                const Text('Address: 123, Tech Avenue, Chennai'),
              ],
              TextButton(
                onPressed: () =>
                    setState(() => _isFullProfile = !_isFullProfile),
                child: Text(_isFullProfile ? 'Show Less' : 'View Full Profile',
                    style: const TextStyle(color: Colors.green)),
              ),
              const SizedBox(height: 20),

              // FAQ Section with Categories
              ExpansionPanelList(
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    _isFAQExpanded = !_isFAQExpanded;
                  });
                },
                children: [
                  ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return const ListTile(title: Text("Have Queries?"));
                    },
                    body: Column(
                      children: [
                        DropdownButtonFormField(
                          decoration: const InputDecoration(
                              labelText: 'Select Category'),
                          items: const [
                            DropdownMenuItem(
                                child: Text('Account Issues'),
                                value: 'account'),
                            DropdownMenuItem(
                                child: Text('App Feedback'), value: 'feedback'),
                            DropdownMenuItem(
                                child: Text('Other Queries'), value: 'other'),
                          ],
                          onChanged: (value) {},
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _feedbackController,
                          maxLines: 5,
                          decoration: const InputDecoration(
                            labelText: 'Your Query or Feedback',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: _handleSubmitFeedback,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6AB547),
                            padding: const EdgeInsets.symmetric(
                                vertical: 9.0, horizontal: 50.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          child: const Text('Submit',
                              style: TextStyle(fontSize: 20)),
                        ),
                      ],
                    ),
                    isExpanded: _isFAQExpanded,
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Expanded Settings with Additional Features
              ExpansionPanelList(
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    _isSettingsExpanded = !_isSettingsExpanded;
                  });
                },
                children: [
                  ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return const ListTile(title: Text("Settings"));
                    },
                    body: Column(
                      children: const [
                        ListTile(
                            leading: Icon(Icons.lock),
                            title: Text("Account Security")),
                        ListTile(
                            leading: Icon(Icons.devices),
                            title: Text("Linked Devices")),
                        ListTile(
                            leading: Icon(Icons.privacy_tip),
                            title: Text("App Permissions")),
                        ListTile(
                            leading: Icon(Icons.color_lens),
                            title: Text("Theme Settings")),
                        ListTile(
                            leading: Icon(Icons.language),
                            title: Text("Language Preferences")),
                      ],
                    ),
                    isExpanded: _isSettingsExpanded,
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // About Us
              const ListTile(
                leading: Icon(Icons.info, color: Colors.green),
                title: Text("About Us"),
                subtitle: Text(
                  "Our company offers cutting-edge technology solutions aimed at improving your workflow and life.",
                ),
              ),
              const SizedBox(height: 20),

              // Logout Button
              ElevatedButton.icon(
                onPressed: () => _handleLogout(context),
                icon: const Icon(Icons.logout, color: Colors.white),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 50.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                label: const Text('Logout',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
              const SizedBox(height: 30),

              // Footer Section
              Column(
                children: const [
                  Text('Contact: support@example.com',
                      style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 8),
                  Text('Terms & Conditions',
                      style: TextStyle(color: Colors.green)),
                  SizedBox(height: 8),
                  Text('© 2024 Rights Reserved',
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSubmitFeedback() {
    String feedback = _feedbackController.text;

    // Validate feedback input
    if (feedback.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your feedback or query")),
      );
      return;
    }

    // Show loading dialog for submitting feedback
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: const [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Submitting feedback..."),
            ],
          ),
        );
      },
    );

    Future.delayed(const Duration(seconds: 2), () {
      // Close the dialog
      Navigator.of(context).pop();

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Feedback submitted successfully")),
      );

      // Clear the feedback input field
      _feedbackController.clear();
    });
  }

  void _handleLogout(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: const [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Logging Out..."),
            ],
          ),
        );
      },
    );

    Future.delayed(const Duration(seconds: 2), () {
      // Close the dialog
      Navigator.of(context).pop();

      // Navigate back to the ProfileScreen
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      ));
    });
  }
}

// Placeholder Edit Profile Screen

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final _formKey = GlobalKey<FormState>(); // Form key for validation
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();

  // Function to simulate saving the changes
  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Text("Saving changes..."),
              ],
            ),
          );
        },
      );

      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pop(context); // Close the dialog
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Your changes have been submitted to the admin."),
        ));
        Navigator.pop(context); // Go back to profile screen
      });
    }
  }

  String? _validateEmail(String? value) {
    const String pattern =
        r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$'; // Basic email pattern
    final RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    const String pattern = r'^\d{10}$'; // Pattern for a 10-digit phone number
    final RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    } else if (!regex.hasMatch(value)) {
      return 'Enter a valid 10-digit phone number';
    }
    return null;
  }

  String? _validateAge(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your age';
    }
    final int? age = int.tryParse(value);
    if (age == null || age <= 0) {
      return 'Enter a valid age';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: const Color(0xFF6AB547),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey, // Assign the form key for validation
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Edit your details here...',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: _validateEmail, // Use custom email validation
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone',
                    border: OutlineInputBorder(),
                  ),
                  validator: _validatePhone, // Use custom phone validation
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _ageController,
                  decoration: const InputDecoration(
                    labelText: 'Age',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number, // Numeric input for age
                  validator: _validateAge, // Use custom age validation
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _designationController,
                  decoration: const InputDecoration(
                    labelText: 'Designation',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your designation';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),
                // Save and Close buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Close without saving
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 30),
                      ),
                      child: const Text('Close'),
                    ),
                    ElevatedButton(
                      onPressed: _saveChanges, // Save changes with validation
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6AB547),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 30),
                      ),
                      child: const Text('Save Changes'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
//MapScreen content

//sign in screen
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _rememberMe = false; // State variable for the checkbox
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  // Error message state variables
  String? _emailError;
  String? _passwordError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo Section
                Center(
                  child: Image.asset(
                    'assets/Splash2.png', // Replace with your logo asset
                    height: 150,
                    width: 150,
                  ),
                ),
                const SizedBox(height: 20),

                // Welcome Text
                const Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Log in to your account',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 30),

                // Email Field
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: const Icon(Icons.email),
                    border: const OutlineInputBorder(),
                    errorText: _emailError, // Display error message
                  ),
                ),
                const SizedBox(height: 20),

                // Password Field
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    border: const OutlineInputBorder(),
                    errorText: _passwordError, // Display error message
                  ),
                ),
                const SizedBox(height: 10),

                // "Remember Me" and "Forgot Password?" Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: _rememberMe, // Use the state variable
                          onChanged: (bool? value) {
                            setState(() {
                              _rememberMe = value ?? false; // Update state
                            });
                          },
                        ),
                        const Text('Remember Me'),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        // Handle Forgot Password action
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Login Button
                ElevatedButton(
                  onPressed: () {
                    // Clear previous error messages
                    setState(() {
                      _emailError = null;
                      _passwordError = null;
                    });

                    // Perform validation
                    if (_emailController.text.isEmpty) {
                      setState(() {
                        _emailError = 'Email is required';
                      });
                    }
                    if (_passwordController.text.isEmpty) {
                      setState(() {
                        _passwordError = 'Password is required';
                      });
                    }

                    if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
                      // Navigate to the tick animation for sign-in success
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const TickAnimation(message: 'Login Successful'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: const Text(
                    'Log In',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // "Don't have an account?" and Register Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // const Text("Don't have an account?"),
                    // TextButton(
                    //   onPressed: () {
                    //     // Navigate to sign-up page
                    //     Navigator.pushNamed(context, '/signup');
                    //   },
                    //   // child: const Text(
                    //   //  // 'Register',
                    //   //   //style: TextStyle(color: Colors.green),
                    //   // ),
                    // ),
                  ],
                ),
                const SizedBox(height: 40),

                // Footer Section
                Column(
                  children: [
                    const Text(
                      'Contact: support@geoat.com',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () {
                        // Handle Terms & Conditions action
                        // For example: Navigator.pushNamed(context, '/terms');
                      },
                      child: const Text(
                        'Terms & Conditions',
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '© 2024 All Rights Reserved',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
