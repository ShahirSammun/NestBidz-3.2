import 'package:flutter/material.dart';
import 'package:mobile_application6/ui/screens/Buyer_homePage.dart';
import 'package:mobile_application6/ui/screens/email_verification.dart';
import 'package:mobile_application6/ui/screens/signup_screen.dart';
import 'package:mobile_application6/ui/widget/screen_background.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _emailError;
  String? _passwordError;

  void _validateAndLogin() {
    setState(() {
      _emailError = null;
      _passwordError = null;

      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      // Email validation (only Gmail or LUS email)
      if (!RegExp(r"^[a-zA-Z0-9._%+-]+@(gmail\.com|lus\.ac\.bd)$")
          .hasMatch(email)) {
        _emailError = "Please enter correct email";}

      password = _passwordController.text.trim();

      if (!RegExp(r'^(?=.*[0-9])(?=.*[!@#%^&*]).{8,}$').hasMatch(password)){
        _passwordError =
        "Please enter correct password.";
      }

      // If no errors -> Navigate
      if (_emailError == null && _passwordError == null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'NESTBIDZ',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),

                // Email
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    prefixIcon: const Icon(Icons.email),
                    errorText: _emailError,
                    errorStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                    suffixIcon: _emailError != null
                        ? const Icon(Icons.warning, color: Colors.red)
                        : null,
                  ),
                ),
                const SizedBox(height: 12),

                // Password
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    errorText: _passwordError,
                    errorStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                    suffixIcon: _passwordError != null
                        ? const Icon(Icons.warning, color: Colors.red)
                        : null,
                  ),
                ),
                const SizedBox(height: 16),

                // Sign In button
                Center(
                  child: ElevatedButton(
                    onPressed: _validateAndLogin,
                    child: const Text('Sign in'),
                  ),
                ),
                const SizedBox(height: 14),

                // Forgot Password
                Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EmailVerification(),
                        ),
                      );
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),

                // Signup link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupScreen(),
                          ),
                        );
                      },
                      child: const Text('Sign up'),
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

