import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/login': (context) => const LoginPage(),
        '/signin': (context) => const SignInScreen(),
        '/signup': (context) => const SignUpScreen(),

      },
    );
  }
}

// Splash Screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Set a timer to navigate to the next screen after 1 second
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed('/onboarding');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              'assets/Splash3.png', // Replace with your logo asset
              width: 1000,
              height: 1000,
            ),
          ),
          // Add a spinner at the center
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                ),
                SizedBox(height: 30), // Space between spinner and bottom of the screen
                Text('Loading...', style: TextStyle(color: Colors.grey)),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
// Onboarding Screen
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: const [
          OnboardingPage1(),
          OnboardingPage2(),
        ],
      ),
    );
  }
}

// First Onboarding Page
class OnboardingPage1 extends StatelessWidget {
  const OnboardingPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/onboarding_image.png', // Replace with your image
                  height: MediaQuery.of(context).size.height * 0.4, // Dynamic size
                ),
                const SizedBox(height: 20),
                const Text(
                  "Welcome to GeoAt!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Track and manage attendance with real-time location verification.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          Positioned(
            top: 40, // Adjust this based on the design
            right: 16,
            child: TextButton(
              onPressed: () {
                // Skip action, navigate directly to login page
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text(
                'Skip',
                style: TextStyle(color: Colors.green, fontSize: 16),
              ),
            ),
          ),
          Positioned(
            bottom: 40, // Adjust based on design
            left: 16,
            right: 16,
            child: ElevatedButton(
              onPressed: () {
                // Navigate to the next onboarding page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OnboardingPage2()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Next'),
            ),
          ),
        ],
      ),
    );
  }
}

// Second Onboarding Page
class OnboardingPage2 extends StatelessWidget {
  const OnboardingPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/geoat_earth.png', // Replace with your image
                  height: MediaQuery.of(context).size.height * 0.4, // Dynamic size
                ),
                const SizedBox(height: 20),
                const Text(
                  "Location Verification",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "We need to access your location to verify your attendance.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          Positioned(
            top: 40, // Adjust based on design
            right: 16,
            child: TextButton(
              onPressed: () {
                // Skip action, navigate directly to login page
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text(
                'Skip',
                style: TextStyle(color: Colors.green, fontSize: 16),
              ),
            ),
          ),
          Positioned(
            bottom: 40, // Adjust based on design
            left: 16,
            right: 16,
            child: ElevatedButton(
              onPressed: () {
                // Navigate to login screen
                Navigator.pushReplacementNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Get Started'),
            ),
          ),
        ],
      ),
    );
  }
}

// Login Screen
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/Splash2.png', // Replace with your logo asset
                height: 150,
                width: 150,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Navigate to User Sign-in page
                Navigator.pushNamed(context, '/signin');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('User Login'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to Admin Sign-in page
                Navigator.pushNamed(context, '/signin');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Admin Login'),
            ),
            const SizedBox(height: 40),
            const Text(
              "Don't know about us? Help",
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
            const Spacer(), // Pushes content above to the center of the screen
            const Divider(thickness: 1),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Contact us: info@company.com | Terms & Conditions | ©2024 All Rights Reserved",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Sign-in Screen
class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/Splash2.png', // Replace with your logo asset
              height: 180,
              width: 180,
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(value: false, onChanged: (bool? value) {}),
                    const Text('Remember Me'),
                  ],
                ),
                const Text('Forgot Password?', style: TextStyle(color: Colors.green)),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                // Handle sign-in logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Sign In'),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                TextButton(
                  onPressed: () {
                    // Navigate to signup page
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: const Text('Register'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Sign-up Screen
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Aligns content between top and bottom
          children: [
            // Logo at the top
            Column(
              children: [
                Image.asset(
                  'assets/Splash2.png', // Replace with your logo asset
                  height: 180,
                  width: 180,
                ),
              ],
            ),

            // Form fields
            Column(
              children: [
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the VerificationScreen when the button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const VerificationScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Sign Up'),
                ),
              ],
            ),

            // Footer content
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                children: [
                  const Text(
                    'By signing up, you agree to our Terms & Conditions',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      // Handle privacy policy tap
                    },
                    child: const Text(
                      'Privacy Policy',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final List<TextEditingController> _otpControllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _otpFocusNodes = List.generate(4, (_) => FocusNode());

  int _timerDuration = 20; // 20 seconds timer for resending code
  Timer? _timer;
  bool _isTimerRunning = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_otpFocusNodes[0]); // Focus on the first OTP field
    });
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _otpFocusNodes) {
      focusNode.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  void _startResendCodeTimer() {
    // Reset the timer state
    setState(() {
      _timerDuration = 20;
      _isTimerRunning = true;
    });

    // Start the countdown timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timerDuration > 0) {
          _timerDuration--;
        } else {
          _isTimerRunning = false;
          timer.cancel();
        }
      });
    });
  }

  void _verifyOTP() async {
    // Show loading screen
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    // Simulate network delay for OTP verification
    await Future.delayed(const Duration(seconds: 2));

    // Close loading screen
    if (mounted) {
      Navigator.pop(context);

      // Navigate to sign-up screen after successful OTP verification
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignUpScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Start the timer whenever the build method is called (i.e., when the page is visited)
    _startResendCodeTimer();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Navigate back to previous screen
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const Text(
                  'Verification',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'We’ve sent you the verification code to your email',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(4, (index) {
                    return _buildOTPInputField(index);
                  }),
                ),
              ],
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    HapticFeedback.lightImpact(); // Haptic feedback on button press
                    _verifyOTP();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  _isTimerRunning
                      ? 'Re-send code in 00:${_timerDuration.toString().padLeft(2, '0')}'
                      : 'Resend Code',
                  style: const TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // OTP Input Field Builder
  Widget _buildOTPInputField(int index) {
    return SizedBox(
      width: 60,
      height: 60,
      child: TextField(
        controller: _otpControllers[index],
        focusNode: _otpFocusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(fontSize: 24),
        decoration: InputDecoration(
          counterText: "",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onChanged: (value) {
          if (value.length == 1 && index != 3) {
            FocusScope.of(context).nextFocus(); // Move to next field
          } else if (value.isEmpty && index != 0) {
            FocusScope.of(context).previousFocus(); // Move to previous field
          }
        },
      ),
    );
  }
}