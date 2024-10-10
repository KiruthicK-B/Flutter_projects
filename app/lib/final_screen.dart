// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'dart:async'; // Import for using Timer

class FinalScreen extends StatefulWidget {
  const FinalScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FinalScreenState createState() => _FinalScreenState();
}

class _FinalScreenState extends State<FinalScreen> {
  int seconds = 0; // Variable to keep track of elapsed seconds
  Timer? timer; // Timer instance
  bool isActive = false; // To check if the timer is running
  bool isCheckedOut = false; // To track checkout status

  // Function to start the timer
  void startTimer() {
    isActive = true; // Set timer state to active
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        seconds++; // Increment the seconds every second
      });
    });
  }

  // Function to stop the timer
  void stopTimer() {
    timer?.cancel(); // Cancel the timer
    isActive = false; // Set timer state to inactive
  }

  // Function to format seconds into hours, minutes, and seconds
  String formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int secs = seconds % 60;
    return "${hours.toString().padLeft(2, '0')}hrs:${minutes.toString().padLeft(2, '0')}mins:${secs.toString().padLeft(2, '0')}s";
  }

  @override
  void initState() {
    super.initState();
    startTimer(); // Start the timer when the screen is initialized
  }

  @override
  void dispose() {
    stopTimer(); // Stop the timer when the widget is disposed
    super.dispose();
  }

  void checkOut() {
    stopTimer(); // Stop the timer on checkout

    // Show a loading dialog
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing the dialog
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Processing..."),
            ],
          ),
        );
      },
    );

    // Wait for 3 seconds before updating the status
    Future.delayed(const Duration(seconds: 3), () {
      // Close the loading dialog
      Navigator.pop(context); 
      
      // Update the checkout status
      setState(() {
        isCheckedOut = true; // Change status to checked out
      });
    });
  }

  void goBackToHome() {
    // Navigate back to the home screen
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF6AB547),
        title: const Text("Check In Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                'assets/profile.jpeg', // Replace with the user's image URL
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Kiruthick B',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text('Location: 11.7321, 78.0489'),
            const SizedBox(height: 10),
            Text('Active Time: ${formatTime(seconds)}'), // Display the formatted time
            const SizedBox(height: 10),
            const Text('Active Status:'),
            Icon(
              isCheckedOut ? Icons.cancel : Icons.check_circle, // Change icon based on status
              color: isCheckedOut ? Colors.red : Colors.green,
              size: 30,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isCheckedOut ? goBackToHome : checkOut, // Call appropriate function
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6AB547),
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 50.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Text(isCheckedOut ? 'Back to Home' : 'Check Out', style: const TextStyle(fontSize: 20)),
            ),
            const SizedBox(height: 20),
            const Text(
              "Great things are done by taking small steps every day. Let’s make today count!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFF6AB547), // Green color
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle, color: Color(0xFF6AB547)),
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
