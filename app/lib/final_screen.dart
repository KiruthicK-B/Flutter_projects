// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, deprecated_colon_for_default_value

import 'dart:async';
import 'package:flutter/material.dart';

import 'index.dart'; // Ensure this import references the appropriate files in your project

// Assuming there's a background timer running in the main screen.
class FinalScreen extends StatefulWidget {
  const FinalScreen({super.key});

  @override
  _FinalScreenState createState() => _FinalScreenState();
}

class _FinalScreenState extends State<FinalScreen> {
  Timer? _timer;
  int _seconds = 0; // This will represent your timer value

  @override
  void initState() {
    super.initState();
    _startTimer(); // Start the timer when the final screen is loaded
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel timer when screen is disposed
    super.dispose();
  }

  void _navigateToProfile() {
    if (mounted) { // Check if the widget is still mounted
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileScreen(timer: _timer), // Passing the timer
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Final Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Timer: $_seconds seconds'),
            ElevatedButton(
              onPressed: _navigateToProfile,
              child: const Text('Go to Profile'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  final Timer? timer; // Pass the timer from the previous screen

  const ProfileScreen({super.key, this.timer});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isFAQExpanded = false; // Control FAQ dropdown state
  bool _isSettingsExpanded = false; // Control Settings dropdown state
  final TextEditingController _feedbackController = TextEditingController();

  // Function to handle logout
  void _handleLogout(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Logging Out..."),
            ],
          ),
        );
      },
    );

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) { // Check if widget is mounted before navigating
        Navigator.pop(context); // Close the loading dialog
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const SignInScreen()),
        );
      }
    });
  }

  // Function to handle feedback submission
  void _handleSubmitFeedback() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Submitting Feedback..."),
            ],
          ),
        );
      },
    );

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) { // Check if widget is mounted before showing a snackbar
        Navigator.pop(context); // Close the loading dialog
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Feedback submitted successfully!")),
        );
      }
    });
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      backgroundColor: const Color(0xFF6AB547),
      title: const Text("Profile"),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/profile.jpeg'),
              ),
              // Positioned widget for the edit button
              Positioned(
                bottom: 0,
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.edit, color: Colors.green),
                  onPressed: () {
                    if (mounted) { // Ensure the widget is still mounted
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ProfileEditScreen(),
                      ));
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Kiruthick B',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text('Email: kiruthick@gmail.com'),
          const SizedBox(height: 5),
          const Text('Phone: +91 9876543210'),
          const SizedBox(height: 5),
          const Text('Age: 28'),
          const SizedBox(height: 5),
          const Text('Designation: Software Engineer'),
          const SizedBox(height: 20),

            // FAQ Section
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
                        child: const Text('Submit', style: TextStyle(fontSize: 20)),
                      ),
                    ],
                  ),
                  isExpanded: _isFAQExpanded,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Settings Section
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
                  body: const Column(
                    children: [
                      ListTile(leading: Icon(Icons.settings), title: Text("Change Password")),
                      ListTile(leading: Icon(Icons.notifications), title: Text("Notification Settings")),
                      ListTile(leading: Icon(Icons.privacy_tip), title: Text("Privacy Settings")),
                      ListTile(leading: Icon(Icons.color_lens), title: Text("Theme Settings")),
                    ],
                  ),
                  isExpanded: _isSettingsExpanded,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // About Us Section
            const ListTile(
              leading: Icon(Icons.info, color: Colors.green),
              title: Text("About Us"),
              subtitle: Text(
                "Our company provides innovative solutions to modern problems. "
                "We aim to make your life easier through technology.",
              ),
            ),
            const SizedBox(height: 20),

            // Logout Button
            ElevatedButton.icon(
              onPressed: () => _handleLogout(context),
              icon: const Icon(Icons.logout, color: Colors.white),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 50.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              label: const Text('Logout', style: TextStyle(fontSize: 20, color: Colors.white)),
            ),

            const SizedBox(height: 30),

            // Footer Section
            const Column(
              children: [
                Text(
                  'Contact: support@example.com',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 8),
                Text('Terms & Conditions', style: TextStyle(color: Colors.green)),
                SizedBox(height: 8),
                Text('© 2024 Rights Reserved', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

