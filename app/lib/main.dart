// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/signin', // Define the initial route
      routes: {
        '/signin': (context) => const SignInScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        // Add more routes if needed
      },
    );
  }
}

// Onboarding screen
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/onboarding_image.png', height: 200), // Add your image asset here
          const Text(
            "Let's Get Started",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _navigateWithLoading(context, '/signin'); // Navigate to SignInScreen with loading screen
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(24),
            ),
            child: const Text('Next'),
          ),
          TextButton(
            onPressed: () {
              _navigateWithLoading(context, '/signin'); // Navigate to SignInScreen with loading screen
            },
            child: const Text('Skip'),
          ),
        ],
      ),
    );
  }
}

// Sign-in screen
class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.asset(
              'assets/logo.png', // Make sure this image exists in the assets folder
              height: 80,
              width: 80,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            // Animated company name (GeoAt) with transition
            AnimatedBuilder(
              animation: ModalRoute.of(context)!.animation!,
              builder: (context, child) {
                return FadeTransition(
                  opacity: ModalRoute.of(context)!.animation!,
                  child: const Text(
                    'GeoAt',
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            // Email Input
            const TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            // Password Input
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Your password',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            // Remember Me and Forgot Password Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(value: false, onChanged: (bool? value) {}),
                    const Text('Remember Me'),
                  ],
                ),
                const Text(
                  'Forgot Password?',
                  style: TextStyle(color: Colors.green),
                ),
              ],
            ),
            // Sign In Button
            ElevatedButton(
              onPressed: () {
                _navigateWithLoading(context, '/signup');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('SIGN IN'),
            ),
            const SizedBox(height: 10),
            // Sign up link
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              child: const Text('Don’t have an account? Sign up'),
            ),
            const Spacer(),
            // Contact Information Row at the bottom
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Contact: '),
                Text('123-456-7890', style: TextStyle(color: Colors.blue)),
                SizedBox(width: 10),
                Text('Email: '),
                Text('support@geoat.com', style: TextStyle(color: Colors.blue)),
              ],
            ),
            const SizedBox(height: 10),
            // Terms and Conditions & Copyright Info
            const Text('Terms & Conditions'),
            const SizedBox(height: 10),
            const Text('© 2024 GeoAt. All rights reserved.'),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

// Sign-up screen
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

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
            // Logo and App Name
            Image.asset(
              'assets/logo.png', // Path to your logo asset
              height: 80,
              width: 80,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            // Animated company name (GeoAt) with transition
            AnimatedBuilder(
              animation: ModalRoute.of(context)!.animation!,
              builder: (context, child) {
                return FadeTransition(
                  opacity: ModalRoute.of(context)!.animation!,
                  child: const Text(
                    'GeoAt',
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            // Full Name Input Field
            const TextField(
              decoration: InputDecoration(
                labelText: 'Full name',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            // Email Input Field
            const TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            // Password Input Field
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Your password',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            // Confirm Password Input Field
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm password',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            // Sign-Up Button
            ElevatedButton(
              onPressed: () {
                _navigateWithLoading(context, '/signin');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('SIGN UP'),
            ),
            const SizedBox(height: 10),
            // Already have an account? Sign in link
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signin'); // Navigate to SignInScreen
              },
              child: const Text('Already have an account? Sign in'),
            ),
            const Spacer(),
            // Contact Information Row at the bottom
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Contact: '),
                Text('123-456-7890', style: TextStyle(color: Colors.blue)),
                SizedBox(width: 10),
                Text('Email: '),
                Text('support@geoat.com', style: TextStyle(color: Colors.blue)),
              ],
            ),
            const SizedBox(height: 10),
            // Terms and Conditions & Copyright Info
            const Text('Terms & Conditions'),
            const SizedBox(height: 10),
            const Text('© 2024 GeoAt. All rights reserved.'),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

// Loading Screen
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(), // Show a loading indicator
            SizedBox(height: 20),
            Text('Loading... Please wait'),
          ],
        ),
      ),
    );
  }
}

// Loading navigation helper function
Future<void> _navigateWithLoading(BuildContext context, String route) async {
  // Check if the widget is still mounted after the async delay
  if (!context.mounted) return;

  // Show the loading screen
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const LoadingScreen()),
  );

  // Simulate a delay (e.g., a network call)
  await Future.delayed(const Duration(seconds: 2));

  // Check again if the widget is still mounted before proceeding
  if (!context.mounted) return;

  // Pop the loading screen
  Navigator.pop(context);

  // Navigate to the actual screen
  Navigator.pushReplacementNamed(context, route);
}
