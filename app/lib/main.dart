// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'index.dart';

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
       // '/signup': (context) => const SignUpScreen(),
        '/index': (context) => const IndexScreen(),

      },
    );
  }
}

class IndexScreen extends StatelessWidget {
  const IndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Index Screen'),
      ),
      body: const Center(
        child: Text('This is the Index Screen'),
      ),
    );
  }
}


// Splash Screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: duplicate_ignore
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
              child: const Text(
                'User Login',
                style: TextStyle(
                  fontWeight: FontWeight.bold, // Make text bold
                  color: Colors.white,          // Set text color to white
                ),
              ),
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
              child: const Text(
                'Admin Login',
                style: TextStyle(
                  fontWeight: FontWeight.bold, // Make text bold
                  color: Colors.white,          // Set text color to white
                ),
              ),
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

// Sign-up Screen
// class SignUpScreen extends StatelessWidget {
//   const SignUpScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween, // Aligns content between top and bottom
//           children: [
//             // Logo at the top
//             Column(
//               children: [
//                 Image.asset(
//                   'assets/Splash2.png', // Replace with your logo asset
//                   height: 180,
//                   width: 180,
//                 ),
//               ],
//             ),

//             // Form fields
//             Column(
//               children: [
//                 const TextField(
//                   decoration: InputDecoration(
//                     labelText: 'Name',
//                     prefixIcon: Icon(Icons.person),
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 const TextField(
//                   decoration: InputDecoration(
//                     labelText: 'Email',
//                     prefixIcon: Icon(Icons.email),
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 const TextField(
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     labelText: 'Password',
//                     prefixIcon: Icon(Icons.lock),
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 const TextField(
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     labelText: 'Confirm Password',
//                     prefixIcon: Icon(Icons.lock),
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Navigate to the VerificationScreen when the button is pressed
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => const VerificationScreen()),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green,
//                     minimumSize: const Size(double.infinity, 50),
//                   ),
//                   child: const Text('Sign Up'),
//                 ),
//               ],
//             ),

//             // Footer content
//             Padding(
//               padding: const EdgeInsets.only(bottom: 10),
//               child: Column(
//                 children: [
//                   const Text(
//                     'By signing up, you agree to our Terms & Conditions',
//                     style: TextStyle(color: Colors.grey),
//                   ),
//                   const SizedBox(height: 10),
//                   GestureDetector(
//                     onTap: () {
//                       // Handle privacy policy tap
//                     },
//                     child: const Text(
//                       'Privacy Policy',
//                       style: TextStyle(
//                         decoration: TextDecoration.underline,
//                         color: Colors.blue,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  // ignore: duplicate_ignore
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
    _startResendCodeTimer();
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
    setState(() {
      _timerDuration = 20;
      _isTimerRunning = true;
    });

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
    // Show tick animation
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const TickAnimation(message: '',)),
    );

    // Wait for 5 seconds before navigating to the index screen
    await Future.delayed(const Duration(seconds: 3));

    // Navigate to the index screen after successful OTP verification
    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, '/index');
  }

  @override
  Widget build(BuildContext context) {
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
                    'Verify',
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

class TickAnimation extends StatefulWidget {
  const TickAnimation({super.key, required String message});

  @override
  _TickAnimationState createState() => _TickAnimationState();
}

class _TickAnimationState extends State<TickAnimation> {
  @override
  void initState() {
    super.initState();
    
    // Start a 5-second timer and navigate to the HomeScreen (index.dart)
    Future.delayed(const Duration(seconds: 2), () {
      // After 5 seconds, navigate to the HomeScreen from index.dart
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()), // Ensure HomeScreen is in index.dart
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 100,
            ),
            SizedBox(height: 20),
            Text(
              'Login Successful',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}