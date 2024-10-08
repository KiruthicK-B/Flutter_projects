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
              Navigator.pushNamed(context, '/signin'); // Navigate to SignInScreen
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
              Navigator.pushNamed(context, '/signin'); // Navigate to SignInScreen
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
              'assets/logo.png',
              height: 80,
              width: 80,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            // App Name
            const Text(
              'GeoAt',
              style: TextStyle(
                fontSize: 32,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
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
            // Sign In Button
            ElevatedButton(
              onPressed: () {
                // Show loading and navigate to home after sign-in
                _navigateWithLoading(context, '/home');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('SIGN IN'),
            ),
            const SizedBox(height: 10),
            // Sign-Up Link
            TextButton(
              onPressed: () {
                // Show loading before navigating to sign-up
                _navigateWithLoading(context, '/signup');
              },
              child: const Text('Don’t have an account? Sign up'),
            ),
          ],
        ),
      ),
    );
  }
}

//sign up_screen
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo and App Name
            Image.asset(
              'assets/logo.png',
              height: 80,
              width: 80,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            const Text(
              'GeoAt',
              style: TextStyle(
                fontSize: 32,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
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
                // Show loading and navigate to sign-in after sign-up
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
                // Show loading before navigating to sign-in
                _navigateWithLoading(context, '/signin');
              },
              child: const Text('Already have an account? Sign in'),
            ),
          ],
        ),
      ),
    );
  }
}


class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Loading...', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}



Future<void> _navigateWithLoading(BuildContext context, String route) async {
  // Show loading screen
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const LoadingScreen()),
  );

  // Simulate a delay
  await Future.delayed(const Duration(seconds: 2));

  // Navigate to the actual screen after the delay
  Navigator.pushReplacementNamed(context, route);
}
